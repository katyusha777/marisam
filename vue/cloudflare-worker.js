addEventListener('fetch', event => {
    event.respondWith(handleRequest(event))
});


const prisonerFieldsToKeep = [
    'Facebook', 'Twitter', 'Website',
    'SortOrder',
    'Year',
    'Years Spent In Prison',
    'Currently in Exile',
    'Status Under Review',
    'Affiliation',
    'Era',
    'State',
    'Race',
    'Gender',
    'released',
    'awaitingTrial',
    'inCustody',
    'inExile',
    'Age',
    'Birthdate',
    'Imprisoned or Exiled',
    'imprisonedOrExiled',
    'Released',
    'Awaiting Trial',
    'In Custody',
    'In Exile',
    'AKA',
    'inmateNumber',
    'Ideologies',
    'Description',
    'name'
];

const caseFieldsToKeep = [
    'Indicted',
    'Convicted',
    'Sentenced Date',
    'Release Date',
    'Charges',
    'Prosecutor',
    'Judge',
    'Plead',
    'Sentence',
    'Institution name',
    'Institution city',
    'Institution state',
    'Institution security',
    'Arrest Date',
    'Incarceration Date',
    'Mailing address',
    'Physical address'
];


const API_URL = 'https://api.airtable.com/v0/appwUa9sdcj6TUQyw';
const API_KEY = "pat9Z3xfALuF3feLF.4652e59586b4315b26ee820f3e6afe0b0ff5e746af7557f51b2c168024b0dec1";
const tables = {
    prisoners: 'tblAbSxbLoPmgPmKS',
    cases: 'tbl9JmSzoJVFMnLjw',
    institutions: 'tblvwNRoG29u91u3h',
};

const CACHE_KEY = 'https://cache.politicalprisoners.org/airtable-response-x2331232';
const CACHE_DURATION_MINUTES = 5;


function calculatePunishment(daysImprisoned, daysInExile) {
    const yearsImprisoned = Math.floor(daysImprisoned / 365);
    const monthsImprisoned = Math.floor((daysImprisoned % 365) / 30.44);
    const daysImprisonedRemainder = Math.floor(daysImprisoned % 30.44);

    const yearsInExile = Math.floor(daysInExile / 365);
    const monthsInExile = Math.floor((daysInExile % 365) / 30.44);
    const daysInExileRemainder = daysInExile % 30;

    let calculatedPunishment = '';

    if (yearsImprisoned || monthsImprisoned || daysImprisonedRemainder) {
        calculatedPunishment += `Imprisoned For ${yearsImprisoned} years ${monthsImprisoned} months ${daysImprisonedRemainder} days`;
    }

    if (yearsInExile || monthsInExile || daysInExileRemainder) {
        if (calculatedPunishment) {
            calculatedPunishment += '<br/>';
        }
        calculatedPunishment += `In Exile For ${yearsInExile} years ${monthsInExile} months ${daysInExileRemainder} days`;
    }

    return calculatedPunishment;
}

function cleanResponse(prisoners) {
    const res = []

    prisoners.forEach((_prisoner) => {
        const prisoner = {}
        prisoner.id = _prisoner.id
        prisoner.Photo = _prisoner.fields.Photo ? _prisoner.fields.Photo[0].thumbnails?.large.url : null
        prisoner.cases = []


        // Prisoner fields
        prisonerFieldsToKeep.forEach((_field) => {
            let value = _prisoner.fields[_field]
            if(typeof value === 'string') value = value.trim()
            prisoner[_field] = value
        })

        // Reset fields
        prisoner['In Exile'] = prisoner['Currently in Exile']

        // Case fields
        let daysImprisoned = 0
        let daysInExile = 0

        if(_prisoner.fields._cases) {
            _prisoner.fields._cases.forEach((_case) => {
                const caseObj = {}
                daysImprisoned += _case['Imprisoned For']
                daysInExile += _case['In Exile For']

                caseFieldsToKeep.forEach((_field) => {
                    caseObj[_field] = _case[_field]
                })
                prisoner.cases.push(caseObj)
            })
        }

        prisoner.inExileFor = daysInExile
        prisoner.imprisonedFor = daysImprisoned
        prisoner.calculatedPunishment = calculatePunishment(daysImprisoned, daysInExile);

        res.push(prisoner)
    })

    res.sort((a, b) => a.SortOrder - b.SortOrder)
    return res
}

async function fetchRecords(tableId) {
    let records = [];
    let offset;
    do {
        const response = await fetch(`${API_URL}/${tableId}?pageSize=100${offset ? `&offset=${offset}` : ''}`, {
            headers: {
                Authorization: `Bearer ${API_KEY}`,
            },
        });
        const data = await response.json();
        records = records.concat(data.records);
        offset = data.offset;
    } while (offset);

    return records;
}

async function handleRequest(event) {
    const cache = caches.default;
    let response = await cache.match(CACHE_KEY);
    //let response = null

    if (!response) {
        const prisonersPromise = fetchRecords(tables.prisoners);
        const casesPromise = fetchRecords(tables.cases);
        const institutionsPromise = fetchRecords(tables.institutions);

        const [prisoners, cases, institutions] = await Promise.all([prisonersPromise, casesPromise, institutionsPromise]);

        for (let prisoner of prisoners) {
            if (prisoner.fields) {
                prisoner.fields._cases = cases.filter(c => c.fields && c.fields.Prisoner && c.fields.Prisoner.includes(prisoner.id))
                    .map(c => {
                        const institution = institutions.find(i => i.fields && i.fields.Cases && i.fields.Cases.includes(c.id));
                        return {
                            ...c.fields,
                            _institution: institution ? institution.fields : null,
                        };
                    });
            }
        }


        const cleanedResponse = cleanResponse(prisoners)

// const filteredPrisoner = prisoners.find(p => p.id === "recLqZBiBJxLZegfv");


        response = new Response(JSON.stringify(cleanedResponse), {
            status: 200,
            headers: {
                'Content-Type': 'application/json',
                'Access-Control-Allow-Origin': '*',
                'Access-Control-Allow-Methods': 'GET,HEAD,POST,OPTIONS',
                'Access-Control-Allow-Headers': '*',
            }
        });

        event.waitUntil(cache.put(CACHE_KEY, response.clone()));
    }

    return response;
}
