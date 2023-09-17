const API_URL = `https://api.airtable.com/v0/appxFZ2jp2w9l3xCe/tblBWHq2Xe2pIY3OA`; // Replace with your app ID
const API_KEY = "patkqatIXPtJNRcAo.9e4b54184c0791561b7ef52065beb0e529573807c7dba49623b0151ebb3f5081"; // Replace with your API key


function createFilterButtons() {
    const filters = ["All cases", "Stings", "Cooperators", "In Custody", "Released", "Awaiting Trial"];
    const filterContainer = document.getElementById("filters");

    filters.forEach((filter, index) => {
        const camelCaseFilter = filter.replace(/[^a-zA-Z0-9]+(.)/g, (_, chr) => chr.toUpperCase());
        const button = document.createElement("button");

        // Set 'All cases' as active by default
        if (index === 0) {
            button.classList.add("active");
        }

        button.innerHTML = filter;
        button.addEventListener("click", function () {
            // Remove active class from all buttons
            document.querySelectorAll("#filters button").forEach(btn => {
                btn.classList.remove("active");
            });

            // Add active class to the clicked button
            this.classList.add("active");

            filterAirtable(camelCaseFilter);
        });

        filterContainer.appendChild(button);
    });
}


createFilterButtons();


function calculateImprisonment(incarcerationDate) {
    const today = new Date();
    const startDate = new Date(incarcerationDate);

    let years = today.getFullYear() - startDate.getFullYear();
    let months = today.getMonth() - startDate.getMonth();
    let days = today.getDate() - startDate.getDate();

    if (days < 0) {
        days += 30;
        months--;
    }

    if (months < 0) {
        months += 12;
        years--;
    }

    return `CURRENT IMPRISONMENT ${years} YEARS, ${months} MONTHS, ${days} DAYS`;
}




function filterAirtable(filterType) {
    // Lowercase the first letter of the filterType to match class names
    const filter = filterType.charAt(0).toLowerCase() + filterType.slice(1);

    const articles = document.querySelectorAll('article.prisoner');

    if (filter === 'allCases') {
        articles.forEach(article => {
            article.style.display = 'block';
        });
        return;
    }

    articles.forEach(article => {
        article.classList.contains(filter) ? article.style.display = 'block' : article.style.display = 'none';
    });
}


const fieldMappings = {
    "name": "Name",
    "Affiliation": "Affiliation",
    "DOB": "Age",
    "Charges": "Charges"
};

// Fetch Data from Airtable
function fetchData() {
    fetch(API_URL, {
        headers: {
            Authorization: `Bearer ${API_KEY}`
        }
    })
        .then(response => response.json())
        .then(data => {
            renderData(data.records);
            document.addEventListener("click", function (event) {
                if (event.target.closest('.showMore')) {
                    const parentArticle = event.target.closest('article');
                    parentArticle.classList.toggle('open');
                }
            });
        })
        .catch(error => console.log('Error:', error));
}

function renderData(records) {
    const container = document.getElementById("airtable-data");

    records.forEach(record => {
        const fields = record.fields;
        fields.Age = fields.Age;  // Already present in the dataset
        const prisonerName = fields.name; // Changed variable name to match the dataset
        const inmateNumber = fields["Prisoner ID"] ?? 'Unknown'; // Unchanged
        const district = fields["Institution State"] ?? 'Unknown'; // Replaced with Institution State
        const sting = fields.Sting ? "Yes" : "No"; // Changed to boolean check
        const fisaNotification = fields["Fisa Notification"] ? "Yes" : "No"; // Field not found in dataset
        const involvesInformant = fields["Involves Informant"] ? "Yes" : "No"; // Field not found in dataset
        const state = fields["Institution State"] ?? 'Unknown'; // Replaced with Institution State
        const chargedDate = fields["Incarceration Date"] ?? 'Unknown'; // Replaced with Incarceration Date
        const age = fields.Age ?? 'Unknown'; // Unchanged
        const gender = fields.Gender ?? 'Unknown'; // Unchanged
        const race = fields.Race ?? 'Unknown'; // Unchanged
        const birthday = fields.Birthdate ?? 'Unknown'; // Changed field name to match dataset
        const affiliation = fields.Affiliation ?? 'Unknown'; // Unchanged
        const description = fields.Description; // Unchanged
        const charges = fields.Charges ?? []; // Unchanged
        const foundGuilty = fields["Found Guilty"] ?? 'Unknown'; // Replaced with Found Guilty
        const sentenced = fields["Sentenced Date"] ?? 'Unknown'; // Replaced with Sentenced Date
        const imprisonment = fields.Inprisonment ?? 'Unknown'; // Changed spelling to match dataset
        const releaseDate = fields["Release Date"] ?? 'Unknown'; // Replaced with Release Date
        const currentImprisonment = "Unknown"; // Field not found in dataset

        const timeSpentInPrison = calculateImprisonment(fields["Incarceration Date"])

        const fieldToClassMap = {
            Sting: 'stings',
            "Involves Informant": 'cooperators',
            "In Custody": 'inCustody',
            Released: 'released',
            "Awaiting Trial": 'awaitingTrial'
        };

        const classNames = Object.keys(fieldToClassMap).filter(f => fields[f]).map(f => fieldToClassMap[f]).join(' ');

        const articleCard = document.createElement('article');
        articleCard.className = `prisoner ${classNames}`;

        let chargesHTML = "";
        fields.Charges.forEach(charge => {
            chargesHTML += `<div class="charge">${charge}</div>`;
        });


        const articleHtml = `
        <header class="flex">
            <h2>${prisonerName}</h2>
            <div class="meta">
                <h3>#${inmateNumber}</h3>
                    <div class="showMore"><div class="isClosed">Show more</div><div class="isOpen">Hide</div></div>
            </div>
        </header>
        <section class="charged">CHARGED: ${chargedDate}</section>
        <main>
            <section class="image">
                <img src="${fields.Photo[0].thumbnails.large.url}" />
            </section>
            <section class="info">
                <div id="info-container">
                    <div class="info-group">
                        <div class="label">AGE</div>
                        <div class="value">${age}</div>
                    </div>
                    <div class="info-group">
                        <div class="label">GENDER</div>
                        <div class="value">${gender}</div>
                    </div>
                    <div class="info-group">
                        <div class="label">RACE</div>
                        <div class="value">${race}</div>
                    </div>
                    <div class="info-group">
                        <div class="label">BIRTHDAY</div>
                        <div class="value">${birthday}</div>
                    </div>
                    <div class="info-group">
                        <div class="label">AFFILIATION</div>
                        <div class="value">${affiliation}</div>
                    </div>
                </div>
                <div class="charges">
                    <div class="title">CHARGES</div>
                    <div class="charges-cnt">
                    ${chargesHTML}
                    </div>
                </div>
                <div class="foundGuilty">
                    FOUND GUILTY: ${foundGuilty}
                </div>
                <div class="sentenced">
                    SENTENCED: ${sentenced}
                </div>
                <div class="conviction">
                    <div>
                        <div>IMPRISONMENT</div>
                        <div>${imprisonment}</div>
                    </div>
                    <div>
                        <div>RELEASE DATE:</div>
                        <div>${releaseDate}</div>
                    </div>
                </div>
            </section>
        </main>
        <div class="currentImprisonment">
        ${timeSpentInPrison}
        </div>
        <section class="moreInfo">
        <section class="header">
            <div>
                <div class="label">DISTRICT</div>
                <div class="title">${district}</div>
            </div>
            <div>
                <div class="label">STING</div>
                <div class="title">${sting}</div>
            </div>
            <div>
                <div class="label">FISA NOTIFICATION</div>
                <div class="title">${fisaNotification}</div>
            </div>
            <div>
                <div class="label">STATE</div>
                <div class="title">${state}</div>
            </div>
            <div>
                <div class="label">INVOLVES INFORMANT</div>
                <div class="title">${involvesInformant}</div>
            </div>
        </section>
        <section class="description">
            ${description}
        </section>
    </section>
        `;

        articleCard.innerHTML = articleHtml;
        container.appendChild(articleCard);
    });
}


// Generate additional information for each card based on field mappings
function generateAdditionalInfoHtml(fields) {
    return Object.keys(fieldMappings).map(key => {
        const value = Array.isArray(fields[key]) ? fields[key].join(", ") : fields[key];
        return `<div><strong>${fieldMappings[key]}:</strong> ${value}</div>`;
    }).join('');
}

// Calculate Age from Date of Birth
function calculateAge(dob) {
    const today = new Date();
    const birthDate = new Date(dob);
    let age = today.getFullYear() - birthDate.getFullYear();
    const m = today.getMonth() - birthDate.getMonth();

    if (m < 0 || (m === 0 && today.getDate() < birthDate.getDate())) {
        age--;
    }

    return age;
}

// Fetch data on window load
window.addEventListener('load', fetchData);
