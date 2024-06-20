<template>
  <section id="vueApp">
  <Suspense><PoliticalPrisoners/></Suspense>
  </section>
</template>

<script lang="ts">
import { Options, Vue } from 'vue-class-component';
import PoliticalPrisoners from './PoliticalPrisoners.vue';
import './index.css'
import './assets/fontawesome/css/all.min.css'
@Options({
  components: {
    PoliticalPrisoners,
  },
})
export default class App extends Vue {}
</script>

<style lang="scss">
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
}
</style>
