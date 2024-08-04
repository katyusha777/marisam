@extends('app')

@section('body')

    <div id="map" style="width: 100%; height: 700px;"></div>

    <script>

        var tiles = L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
                maxZoom: 18,
                attribution: '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors, Points &copy 2012 LINZ'
            }),
            latlng = L.latLng(40, -92);


        var map = L.map('map', {center: latlng, zoom: 4, layers: [tiles]});

        var markers = L.markerClusterGroup();

        async function loadPrisoners() {
            const request = await axios.get('https://marisam-airtable.patrickdeamorim.workers.dev/')
            console.log(request)
            const records = []
            request.data.forEach((item) => {
                const prisoner = {
                    name: item.name,
                    image: item.Photo,
                    latitude: item.cases && item.cases[0]  && item.cases[0].Latitude ? item.cases[0].Latitude[0] : null,
                    longitude: item.cases && item.cases[0] && item.cases[0].Longitude ? item.cases[0].Longitude[0] : null,
                    affiliation: item.Affiliation ? item.Affiliation[0] : null,
                    race: item.Race,
                    gender: item.Gender,
                    age: item.Age,
                    inmate_number: item.Age,
                    description: item.Description,
                    imprisoned_for: item.calculatedPunishment,
                    imprisonment_length: item.imprisonedFor,
                    in_custody: item["In Custody"],
                }

                records.push(prisoner)
            })

            records.forEach((prisoner) => {
                var title = prisoner.name;
                var marker = L.marker(new L.LatLng(prisoner.latitude, prisoner.longitude), { title: title });
                marker.bindPopup(`
                <div class="mb-3 text-center"><b>${prisoner.name}</b></div>
                <div class="mb-1"><img src="${prisoner.image}" class="rounded block center"/><br/></div>
                <div class="text-center"><span>${prisoner.imprisoned_for}</span></div>
                `);
                markers.addLayer(marker);
            })

            map.addLayer(markers);
        }

        loadPrisoners()
    </script>

    <style type="text/css">
        #map { height: 480px; }

    </style>
@endsection
