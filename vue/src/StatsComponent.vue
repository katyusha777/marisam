<script lang="ts" setup>
import { ref } from 'vue';
import { DoughnutChart } from 'vue-chart-3';
import useAirtable from "@/composables/useAirtable";
import BarGraphComponent from "@/BarGraphComponent.vue";

const { records, fetchRecords, aggregateCounts, sumCounts } = useAirtable();
const chartDataEra = ref({})
const chartDataGender = ref({})
const chartDataRace = ref({})
const dataColors = [
  '#825af9',
  '#35d9c3',
  '#4375ff',
  '#6d3dbf',
  '#2cb1a1',
  '#3658d4'
]

const chartOptions = ref({
  responsive: true,
  elements: {
    arc: {
      borderWidth: 0
    }
  },
  plugins: {
    legend: {
      display: false
    },
    title: {
      display: false,
    },
  },
});

const prepareChartData = (key: any) => {
  return {
    labels: Object.keys(aggregateCounts[key]),
    datasets: [{
      data: Object.values(aggregateCounts[key]),
      backgroundColor: dataColors
    }]
  };
};

const renderAggregateCounts = (key: string): string => {
  const entries = Object.entries(aggregateCounts[key]);
  return entries.map(([label, count], index) => {
    const color = dataColors[index % dataColors.length];
    return `<span class="font-bold" style="color: ${color};">${count} ${label}s</span>`;
  }).join(', ');
}

// This will return a string with each count and label wrapped in a span with the corresponding color.
await fetchRecords()
chartDataEra.value = prepareChartData('Era')
chartDataGender.value = prepareChartData('Gender')
chartDataRace.value = prepareChartData('Race')


interface IDisplayElement {
  key: string
  label: string
  info: string
}


const chartElements: Array<IDisplayElement> = [
  {key: 'race', label: 'Racial Composition', info: `The racial composition of political prisoners - ${renderAggregateCounts('Race')} - speaks volumes about the intersection of race and political dissent in the United States.<br/><br/>
  These statistics compel us to question how race influences both the likelihood of becoming a political prisoner and the experiences of these individuals within the justice system.`},

  {key: 'gender', label: 'Gender Disparity', info: `In examining the stark disparity between genders - ${renderAggregateCounts('Gender')} - the data reflects a broader societal narrative.<br/><br/>
  It's essential to delve deeper into these numbers to understand the underlying causes of such a vast gender gap in political imprisonment, considering factors like historical marginalization, societal expectations, and the different risks and challenges faced by each gender in their pursuit of justice and equality.`}
]

const sumElementsSmallNumbers: Array<IDisplayElement> = [
  {
    key: 'individualsInExile',
    label: 'Individuals in Exile',
    info: 'The count of individuals in exile underscores the harsh realities faced by those who challenge systemic powers. Their exile is a stark reminder of the sacrifices made in the pursuit of social and political change.'
  },
  {
    key: 'individualsImprisoned',
    label: 'Individuals Imprisoned',
    info: 'This figure represents a broader narrative of political resistance, encompassing those who face incarceration and exile. Their stories are emblematic of a larger struggle for justice and the ongoing fight against systemic oppression.'
  }
    ]

const sumElements: Array<IDisplayElement> = [
  {
    key: 'accumulatedDaysImprisoned',
    label: 'Days Imprisoned',
    info: 'This number reflects the staggering amount of time individuals, often activists and dissidents, have been confined. It symbolizes the enduring struggle against systemic injustice and the long shadow cast by policies that disproportionately target marginalized communities.'
  },
  {
    key: 'accumulatedDaysInExile',
    label: 'Days in Exile',
    info: 'Exile, a forced separation from one\'s homeland, often results from standing against oppressive regimes. This figure represents not just days lost, but lives uprooted and voices silenced in the fight for justice and human rights.'
  }
]

</script>

<template>
  <section id="stats-component">

    <BarGraphComponent/>

    <div class="" id="counters">
      <div class="counter flex-col-reverse md:flex-row flex md:justify-between mb-24 md:mb-32" v-for="element in sumElements">
        <div class="w-full md:w-1/2 text-left">
          <div class="counter-label title-label"><sub>collective</sub>{{element.label}}</div>
          <div class="counter-info pr-16"><p>{{element.info}}</p></div>
        </div>
        <div class="w-full md:w-1/2 text-right counter-value pt-12">
          <vue3-autocounter ref='counter' :startAmount='0' :endAmount='sumCounts[element.key]' :duration='5' separator=',' :decimals='0' :autoinit='true'/>
        </div>
      </div>
    </div>

    <div id="charts">
      <div v-for="(element, index) in chartElements" :key="index" class="chart mb-24 md:mb-32 flex-col-reverse md:flex-row flex md:justify-between">
        <div v-if="index % 2 === 0" class="w-full md:w-1/2 text-left">
          <div class="chart-label title-label">{{ element.label }}</div>
          <div><p v-html="element.info"></p></div>
        </div>
        <div class="w-full md:w-1/2 chart-value mb-12">
          <DoughnutChart :options="chartOptions" :chartData="element.key === 'gender' ? chartDataGender : chartDataRace" />
        </div>
        <div v-if="index % 2 !== 0" class="w-full md:w-1/2 text-left">
          <div class="chart-label title-label">{{ element.label }}</div>
          <div><p v-html="element.info"></p></div>
        </div>
      </div>
    </div>


    <div class="" id="counters-small">
      <div class="counter block md:flex md:justify-between mb-24 md:mb-32" v-for="element in sumElementsSmallNumbers">
        <div class="w-full md:w-2/5  counter-value">
          <vue3-autocounter ref='counter' :startAmount='0' :endAmount='sumCounts[element.key]' :duration='5' separator='' :decimals='0' :autoinit='true'/>
        </div>
       <div class="w-full md:w-3/5 text-left">
         <div class="counter-label title-label">{{element.label}}</div>
         <div class="counter-info"><p>{{element.info}}</p></div>
       </div>
      </div>
    </div>


  </section>
</template>

<style lang="scss" scoped>

p {
  font-size: 1.2rem;
  line-height: 1.6rem;

  @media (max-width: 800px) {
    font-size: 1rem;
  }
}

#stats-component {
  background: #000;
  color:#FFF;
  padding: 5rem 0 2rem;
}

.title-label {
  font-size: 2.8rem;
  text-transform: uppercase;
  font-weight: bold;
  margin-bottom: 1rem;
  position: relative;
  font-family: 'Roboto', sans-serif;

  @media (max-width: 800px) {
    font-size: 2rem;
    text-transform: none;
  }

  sub {
    position: absolute;
    text-transform: uppercase;
    font-size: 1rem;
    top: -.9rem;
  }
}

#charts, #counters, #counters-small {
  max-width: 980px;
  margin:auto;

  .counter-value {
    font-size: 8rem;
    line-height: 120px;
    text-align: right;
    font-weight: bold;

    @media (max-width: 800px) {
      font-size: 5rem;
      line-height: unset;
      text-align: left;
      padding-top: 0;
      position: relative;
      top: -40px;
    }
  }
}

#counters-small {

  .counter-value {
    padding-right: 2rem;
    text-align: right;

    @media (max-width: 800px) {
      text-align: left;
    }
  }
}
</style>
