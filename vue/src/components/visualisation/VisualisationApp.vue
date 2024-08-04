<template>
  <section id="vueApp" class="unset-width" style="background: #000">
    <Suspense>
      <VisualisationComponent/>
    </Suspense>
  </section>
</template>
<script setup lang="ts">

import VisualisationComponent from "@/components/visualisation/VisualisationComponent.vue";
</script>
