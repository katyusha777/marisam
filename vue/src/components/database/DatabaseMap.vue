<script setup lang="ts">
// @ts-nocheck

import '../../assets/leaflet/leaflet.css'
import '../../assets/leaflet/MarkerCluster.css'
import '../../assets/leaflet/MarkerCluster.Default.css'
import '../../assets/leaflet/leaflet.js'
import '../../assets/leaflet/markercluster.js'
import {defineProps, onMounted, watch} from "vue";
import {PrisonerRecord} from "@/@types/types";

interface Props {
  records: PrisonerRecord[]
}

const props = defineProps<Props>()

let map = null
let markers = null

onMounted(() => {
  const tiles = L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
        maxZoom: 18,
        attribution: '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors, Points &copy 2012 LINZ'
      }),
      latlng = L.latLng(40, -92);


   map = L.map('map', {center: latlng, zoom: 4, layers: [tiles]});
   markers = L.markerClusterGroup();
  setMarkers()
})

function setMarkers() {
  markers.clearLayers()
  props.records.forEach((prisoner: PrisonerRecord) => {
    if(!prisoner.latitude || !prisoner.longitude) return false
    var title = prisoner.name;
    var marker = L.marker(new L.LatLng(prisoner.latitude, prisoner.longitude), { title: title });
    marker.bindPopup(`
                <div class="mb-3 text-center"><b>${prisoner.name}</b></div>
                <div class="mb-1"><img src="${prisoner.Photo}" class="rounded block center"/><br/></div>
                <div class="text-center"><span>${prisoner.imprisonedFor}</span></div>
                `);
    markers.addLayer(marker);
  })

  map.addLayer(markers);
}


watch(() => props.records, (newRecords, oldRecords) => {
  setMarkers()
}, { deep: true });
</script>


<template>
  <div id="map" style="width: 100%;height:500px;margin-bottom: 2rem; border-radius: 10px; overflow: hidden"></div>
</template>


<style lang="scss">
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
}
</style>
