<template>
  <section id="vueApp" class="unset-width">
    <Suspense>
      <GalleryComponent/>
    </Suspense>
  </section>
</template>

<script lang="ts">
import { Options, Vue } from 'vue-class-component';
import './index.css'
import './assets/fontawesome/css/all.min.css'
import GalleryComponent from "@/GalleryComponent.vue";
@Options({
  components: {
    GalleryComponent,
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

.unset-width {
  width:unset !important;
}
</style>
