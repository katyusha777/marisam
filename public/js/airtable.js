const API_URL = `https://api.airtable.com/v0/appxFZ2jp2w9l3xCe/tblBWHq2Xe2pIY3OA`; // Replace with your app ID
const API_KEY = "patkqatIXPtJNRcAo.9e4b54184c0791561b7ef52065beb0e529573807c7dba49623b0151ebb3f5081"; // Replace with your API key


window.filters = {}
window.filters["affiliations"] = []
window.filters["ideologies"] = []
window.filters["states"] = []

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


function calculateImprisonment(incarcerationDate, releaseDate, inExile = false) {
    const today = releaseDate ? new Date(releaseDate) : new Date();
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

    if (!years || isNaN(years)) return null

    const firstWord = inExile ? 'IN EXILE' : 'IMPRISONED'
    return `${firstWord} FOR ${years} YEARS, ${months} MONTHS, ${days} DAYS`;
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

function removeDuplicates(arr) {
    return arr.filter((item,
        index) => arr.indexOf(item) === index);
}

function renderData(records) {
    const container = document.getElementById("airtable-data");

    records.forEach(record => {
        const fields = record.fields;
        fields.Age = fields.Age;  // Already present in the dataset
        const prisonerName = fields.name; // Changed variable name to match the dataset
        const inmateNumber = fields["Prisoner ID"] ?? null; // Unchanged
        const district = fields["Institution State"] ?? null; // Replaced with Institution State
        const sting = fields.Sting ? "Yes" : "No"; // Changed to boolean check
        const fisaNotification = fields["Fisa Notification"] ? "Yes" : "No"; // Field not found in dataset
        const involvesInformant = fields["Involves Informant"] ? "Yes" : "No"; // Field not found in dataset
        const state = fields["Institution State"] ?? null; // Replaced with Institution State
        const chargedDate = fields["Incarceration Date"] ?? null; // Replaced with Incarceration Date
        const age = fields.Age ?? null; // Unchanged
        const gender = fields.Gender ?? null; // Unchanged
        const race = fields.Race ?? null; // Unchanged
        const birthday = fields.Birthdate ?? null; // Changed field name to match dataset
        const affiliation = fields.Affiliation ?? null; // Unchanged
        const description = fields.Description; // Unchanged
        const charges = fields.Charges ?? []; // Unchanged
        const foundGuilty = fields["Found Guilty"] ?? null; // Replaced with Found Guilty
        const sentenced = fields["Sentenced Date"] ?? null; // Replaced with Sentenced Date
        const imprisonment = fields.Inprisonment ?? null; // Changed spelling to match dataset
        const releaseDate = fields["Release Date"] ?? null; // Replaced with Release Date
        const AKA = fields["AKA"] ?? null; // Replaced with Release Date
        const currentImprisonment = "Unknown"; // Field not found in dataset

        const startPunishmentDate = fields["In Exile"] ? fields["In Exile Since"] : fields["Incarceration Date"]
        const timeSpentInPrison = calculateImprisonment(startPunishmentDate, fields["Release Date"] ?? null, fields["In Exile"])

        const fieldToClassMap = {
            Sting: 'stings',
            "Involves Informant": 'cooperators',
            "In Custody": 'inCustody',
            Released: 'released',
            "Awaiting Trial": 'awaitingTrial'
        };

        const classNames = Object.keys(fieldToClassMap).filter(f => fields[f]).map(f => fieldToClassMap[f]);
        classNames.push(fields["Affiliation"])
        classNames.push(fields["Institution State"])

        if (fields["Institution State"]) window.filters["states"].push(fields["Institution State"])
        if (fields["Affiliation"]) window.filters["affiliations"].push(fields["Affiliation"])
        if (fields["Ideologies"] && fields["Ideologies"].length) {
            fields["Ideologies"].forEach((ideology) => {
                classNames.push(ideology.replace(/[^a-zA-Z0-9]/g, '-').toLowerCase());
                window.filters["ideologies"].push(ideology)
            }
            )
        }

        const articleCard = document.createElement('article');
        articleCard.className = `prisoner ${classNames.join(' ')}`;

        let chargesHTML = "";
        if (fields.Charges) {
            fields.Charges.forEach(charge => {
                chargesHTML += `<div class="charge">${charge}</div>`;
            });
        }


        const articleHtml = `
        <header class="flex">
        ${AKA ? `${AKA} (${prisonerName})`
                : `<h2>${prisonerName}</h2>`}
            
            <div class="meta">
                ${inmateNumber ? `<h3>#${inmateNumber}</h3>` : ''}
                    <div class="showMore"><div class="isClosed">Show more</div><div class="isOpen">Hide</div></div>
            </div>
        </header>
        ${chargedDate ? `<section class="charged">CHARGED: ${chargedDate}</section>` : ''}
        <main>
            <section class="image">
                <img src="${fields.Photo ? fields.Photo[0].thumbnails.large.url : ''}" />
            </section>
            <section class="info">
            <div id="info-container">
            ${age && !isNaN(age) ? `<div class="info-group">
                         <div class="label">AGE</div>
                         <div class="value">${age}</div>
                     </div>` : ''
            }
            ${gender ? `<div class="info-group">
                             <div class="label">GENDER</div>
                             <div class="value">${gender}</div>
                         </div>` : ''
            }
            ${race ? `<div class="info-group">
                         <div class="label">RACE</div>
                         <div class="value">${race}</div>
                     </div>` : ''
            }
            ${birthday ? `<div class="info-group">
                             <div class="label">BIRTHDAY</div>
                             <div class="value">${birthday}</div>
                         </div>` : ''
            }
            ${affiliation ? `<div class="info-group">
                                 <div class="label">AFFILIATION</div>
                                 <div class="value">${affiliation}</div>
                             </div>` : ''
            }
        </div>
     
        ${chargesHTML ? `
        <div class="charges">
        <div class="title">CHARGES</div>
        <div class="charges-cnt">
        ${chargesHTML}
        </div>
        ` : ''}
    </div>
    ${foundGuilty ? `<div class="foundGuilty">
                        FOUND GUILTY: ${foundGuilty}
                    </div>` : ''
            }
    ${sentenced ? `<div class="sentenced">
                        SENTENCED: ${sentenced}
                   </div>` : ''
            }
            <div class="conviction">
            
                ${imprisonment ? `<div><div>IMPRISONMENT</div>
                                <div>${imprisonment}</div></div>` : ''
            }
            
            
                ${releaseDate ? `<div><div>RELEASE DATE:</div>
                               <div>${releaseDate}</div></div>` : ''
            }
            
        </div>

            </section>
        </main>
        <div class="currentImprisonment">
        ${timeSpentInPrison}
        </div>
        <section class="moreInfo">
        <section class="header">
        ${district ? `<div>
                          <div class="label">DISTRICT</div>
                          <div class="title">${district}</div>
                      </div>` : ''
            }
       
    </section>

        <section class="description">
            ${description ?? ''}
        </section>
    </section>
        `;

        articleCard.innerHTML = articleHtml;
        container.appendChild(articleCard);
    });

    window.filters["states"] = removeDuplicates(window.filters["states"])
    window.filters["affiliations"] = removeDuplicates(window.filters["affiliations"])
    window.filters["ideologies"] = removeDuplicates(window.filters["ideologies"])
    populateFiltersFromWindowObject();

}


function initializeFilterListeners() {
    const affiliationSelect = document.querySelector("#ideologies-filter");
    const stateSelect = document.querySelector("#state-filter");

    affiliationSelect.addEventListener("change", filterArticles);
    stateSelect.addEventListener("change", filterArticles);
}

function filterArticles() {
    // Get selected options
    const selectedIdeologies = document.querySelector("#ideologies-filter").value.replace(/[^a-zA-Z0-9]/g, '-').toLowerCase();
    const selectedState = document.querySelector("#state-filter").value;
    console.log(selectedIdeologies)

    // Get all articles with the 'prisoner' class
    const articles = document.querySelectorAll("article.prisoner");

    articles.forEach((article) => {
        let shouldShow = true;

        // Check if article should be shown based on affiliation
        if (selectedIdeologies) {
            shouldShow = article.classList.contains(selectedIdeologies);
        }

        // Check if article should be shown based on state
        if (shouldShow && selectedState) {
            shouldShow = article.classList.contains(selectedState);
        }

        // Show or hide the article based on the above checks
        if (shouldShow) {
            article.style.display = "block";
        } else {
            article.style.display = "none";
        }
    });
}



// Generate additional information for each card based on field mappings
function generateAdditionalInfoHtml(fields) {
    return Object.keys(fieldMappings).map(key => {
        const value = Array.isArray(fields[key]) ? fields[key].join(", ") : fields[key];
        return `<div><strong>${fieldMappings[key]}:</strong> ${value}</div>`;
    }).join('');
}


function populateFiltersFromWindowObject() {
    // Validate if window.filters is present and is an object
    if (typeof window.filters !== 'object') {
        console.error('window.filters is not defined or not an object.');
        return;
    }

    // Extract data from window.filters
    const { affiliations, states, ideologies } = window.filters;

    // Validate that the necessary fields exist
    if (!Array.isArray(affiliations) || !Array.isArray(states)) {
        console.error('affiliations or states is not defined or not an array in window.filters.');
        return;
    }

    // Function to populate a single select
    const populateSingleSelect = (selectId, optionsArray) => {
        const selectElement = document.querySelector(selectId);
        optionsArray.forEach((optionValue) => {
            const optionElement = document.createElement('option');
            optionElement.value = optionValue;
            optionElement.text = optionValue;
            selectElement.appendChild(optionElement);
        });
    };

    // Populate the select elements
    // populateSingleSelect("#affiliation-filter", affiliations);
    populateSingleSelect("#state-filter", states);
    populateSingleSelect("#ideologies-filter", ideologies);
    initializeFilterListeners();

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
