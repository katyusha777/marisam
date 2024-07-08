<template>
  <section id="vueApp" class="unset-width">
    <Suspense>
      <GraphComponent/>
    </Suspense>
    <Suspense>
      <NumbersComponent/>
    </Suspense>
  </section>
</template>
<script setup lang="ts">
import GraphComponent from "@/components/visualisation/GraphComponent.vue";
import NumbersComponent from "@/components/visualisation/NumbersComponent.vue";
</script>
