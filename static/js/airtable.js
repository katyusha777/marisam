const API_URL = `https://api.airtable.com/v0/appxFZ2jp2w9l3xCe/tblBWHq2Xe2pIY3OA`; // Replace with your app ID
const API_KEY = "patkqatIXPtJNRcAo.9e4b54184c0791561b7ef52065beb0e529573807c7dba49623b0151ebb3f5081"; // Replace with your API key

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
        })
        .catch(error => console.log('Error:', error));
}

// Render the data in the HTML
function renderData(records) {
    const container = document.getElementById("airtable-data");

    records.forEach(record => {
        const fields = record.fields;
        fields.Age = calculateAge(fields.DOB);
        const additionalInfo = generateAdditionalInfoHtml(fields);

        const articleCard = document.createElement('article');
        articleCard.className = "feature js-link-event";

        const articleHtml = `
      <div class="feature-photo" style="background-image:url('${fields.Photo[0].thumbnails.large.url}')">
      </div>
      <div class="item">
        <h3 class="h4">${fields.name}</h3>
        <p>${fields.description}</p>
        <div class="info">
          ${additionalInfo}
        </div>
      </div>
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
