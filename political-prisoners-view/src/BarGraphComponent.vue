<script lang="ts" setup>
import useAirtable from "@/composables/useAirtable";
import {PrisonerRecord} from "@/types";

const { records, fetchRecords } = useAirtable();
await fetchRecords();

type TDataValue = Record<string, Record<number, number>>
type TDataKeys = 'race' | 'gender' | 'ideology' | 'affiliation'

const data: Record<TDataKeys, TDataValue> = {
  race: {},
  gender: {},
  ideology: {},
  affiliation: {}
}


const chartOptions = (title: string, eras: Array<number>) => {
  return {
    theme: {mode: 'dark',palette: 'palette10'},
    chart: { type: 'bar', height: 350, stacked: true, background: '#000'},
    tooltip: {theme: 'dark'},
    plotOptions: {
      bar: { horizontal: false, dataLabels: { total: { enabled: true, offsetX: 0, style: { fontSize: '13px', fontWeight: 900} } } }, },
    title: {text: `...${title}`},
    xaxis: {categories: eras, },
    yaxis: {labels: { formatter: function (val: any) { return val + "" } }},
    legend: { position: 'top', horizontalAlign: 'left', offsetX: 40}
  }
}

const setDataValue = (key: TDataKeys, value: string, years: Array<number>) => {
  if(!value) return false
  if(typeof data[key][value] === 'undefined') data[key][value] = {}
  years.forEach((year: number) => {
    if(typeof data[key][value][year] === 'undefined') data[key][value][year] = 0
    data[key][value][year]++
  })
}

records.value.forEach((record: PrisonerRecord) => {
  const yearsInPrison = record['Years Spent In Prison']
  const race = record.Race
  const gender = record.Gender
  const affiliation = record.Affiliation
  const ideology = record.Ideologies ? record.Ideologies[0] : null

  if(!yearsInPrison) return
  const years: Array<number> = []
  yearsInPrison.forEach((year: string) => {
    years.push(parseInt(year))
  })

  if(!years) return false
  setDataValue('race', race, years)
  setDataValue('gender', gender, years)
  setDataValue('affiliation', affiliation, years)
  if(ideology) setDataValue('ideology', ideology, years)
})





const parseDataForChart = (dataKey: TDataKeys, title: string): {series: any, eras: any, options: any} => {
  const series: any = [];

  const erasUnsorted: Array<number> = []
  Object.keys(data[dataKey]).forEach((key: string) => {
    Object.keys(data[dataKey][key]).forEach((eraNumber: string) => {
      erasUnsorted.push(parseInt(eraNumber))
    })
  })

  const eras = erasUnsorted
      .filter((value, index, self) => self.indexOf(value) === index)
      .sort((a, b) => a - b);


  Object.keys(data[dataKey]).forEach((key: string) => {
    const seriesSubData: Array<number> = []
    eras.forEach((era: number) => {
      const count = data[dataKey][key][era] ?? 0
      seriesSubData.push(count)
    })

    series.push({name: key, data: seriesSubData})
  })

  const options = chartOptions(title, eras)
  return { series, eras, options }
}




const race = parseDataForChart('race', 'Race')
const gender = parseDataForChart('gender', 'Gender')
const ideology = parseDataForChart('ideology', 'Ideology')
const affiliation = parseDataForChart('affiliation', 'Affiliation')

const barCntClasses = 'mb-8 w-11/12 mx-auto'
</script>

<template>


<div class="mb-12">
  <h2 style="
    text-align: center;
    text-transform: uppercase;
    font-size: 2rem;
    font-weight: bold;
"># of Political Prisoners by Year, grouped by...</h2>

  <div :class="barCntClasses"><apexchart type="bar" height="350" :options="race.options" :series="race.series"></apexchart></div>
  <div :class="barCntClasses"><apexchart type="bar" height="350" :options="gender.options" :series="gender.series"></apexchart></div>
  <div :class="barCntClasses"><apexchart type="bar" height="350" :options="ideology.options" :series="ideology.series"></apexchart></div>
  <div :class="barCntClasses"><apexchart type="bar" height="350" :options="affiliation.options" :series="affiliation.series"></apexchart></div>

</div>
</template>