import { createApp } from 'vue'
import App from './App.vue'
import AppStatsContainer from './AppStatsContainer.vue'
import AppGallery from './AppGallery.vue'
import Vue3autocounter from 'vue3-autocounter';

import Antd from 'ant-design-vue';
import 'ant-design-vue/dist/reset.css';
// @ts-ignore
import VueApexCharts from "vue3-apexcharts";

import { Chart, registerables } from 'chart.js';
Chart.register(...registerables);

const app = createApp(App).use(Antd)
const appGallery = createApp(AppGallery).use(Antd)
const appStats = createApp(AppStatsContainer).use(Antd).component('vue3-autocounter', Vue3autocounter).use(VueApexCharts);

// app.mount('#app')
appStats.mount('#app-stats')
// appGallery.mount('#app-gallery')
