import { createApp } from 'vue'
import App from './App.vue'
import AppStats from './AppStats.vue'
import Vue3autocounter from 'vue3-autocounter';

import Antd from 'ant-design-vue';
import 'ant-design-vue/dist/reset.css';

import { Chart, registerables } from 'chart.js';
Chart.register(...registerables);

const app = createApp(App).use(Antd)
const appStats = createApp(AppStats).use(Antd).component('vue3-autocounter', Vue3autocounter)

// app.mount('#app')
appStats.mount('#app-stats')
