import { createApp } from 'vue'
import DatabaseApp from './components/database/DatabaseApp.vue'
import VisualisationApp from './components/visualisation/VisualisationApp.vue'
import GalleryApp from './components/gallery/GalleryApp.vue'
import Vue3autocounter from 'vue3-autocounter';


import Antd from 'ant-design-vue';
import 'ant-design-vue/dist/reset.css';
import './assets/style.css'
// @ts-ignore
import VueApexCharts from "vue3-apexcharts";

import { Chart, registerables } from 'chart.js';
Chart.register(...registerables);

const app = createApp(DatabaseApp).use(Antd)
const appGallery = createApp(GalleryApp).use(Antd)
const appStats = createApp(VisualisationApp).use(Antd).component('vue3-autocounter', Vue3autocounter).use(VueApexCharts);

app.mount('#app')
// appStats.mount('#app-stats')
// appGallery.mount('#app-gallery')
