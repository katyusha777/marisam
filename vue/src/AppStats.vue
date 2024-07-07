<script setup lang="ts">
import { Position } from '@unovis/ts'
import { VisAxis, VisCrosshair, VisStackedBar, VisTooltip, VisXYContainer } from '@unovis/vue'
import {  DataRecord, FormatConfig } from './data'
import useAirtable from "@/composables/useAirtable";
import {ref} from "vue";
import {PrisonerRecord} from "@/types";

const { records, fetchRecords, aggregateCounts, sumCounts } = useAirtable();
await fetchRecords();

/** ======================================== **/


type TDataValue = Record<string, Record<number, number>>
type TDataKeys = 'race' | 'gender' | 'ideology' | 'affiliation'

const chartKeys = ['race', 'gender', 'ideology', 'affiliation']

const data: Record<TDataKeys, TDataValue> = {
  race: {},
  gender: {},
  ideology: {},
  affiliation: {}
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


const prepareData = (dataKey: TDataKeys): {series: any, eras: any} => {
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

  return { series, eras }
}


type TransformedData = Record<string, number | string>;

 function transformData(input: Record<string, any[]>): TransformedData[] {
  const { series, eras } = input;
  return eras.map((year: any, index: any) => {
    const dataPoint: TransformedData = { year };
    series.forEach(({ name, data }) => {
      dataPoint[name] = data[index];
    });
    return dataPoint;
  });
}

 function generateLabels(series: any[]): FormatConfig[] {
  return series.map((item, index) => ({
    format: item.name,
    color: `var(--vis-color${index})`,
    icon: 'cassette-fill',
    label: item.name,
  }));
}


const preparedData = {
  race: prepareData('race'),
  gender: prepareData('gender'),
  ideology: prepareData('ideology'),
  affiliation: prepareData('affiliation'),
}




/** ======================================== **/

const labels = ref<any>(generateLabels(preparedData.gender.series))
const chartData = ref<any>(transformData(preparedData.gender))

function setChartData(key: TDataKeys) {
  labels.value = generateLabels(preparedData[key].series)
  chartData.value = transformData(preparedData[key])
}

const height = 450

function getIcon(f: any): string {
  return `<span class="bi bi-${f.icon}" style="color:${f.color}; margin:0 4px"></span>${f.label}\t`
}

function tooltipTemplate(d: any): string {
  const dataLegend = labels.value.filter(f => d[f.format] > 0)
      .reverse()
      .map(f => `<span>${getIcon({ ...f, label: d[f.format] })}`)
      .join('</span>')
  return `<div><b>${d.year}</b>: ${dataLegend}</div>`
}
</script>

<template>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.9.1/font/bootstrap-icons.css" />


  <button style="text-transform: capitalize; border: 1px solid #000; border-radius: 10px; padding: 8px 4px; margin: 0 1rem;" v-for="key in chartKeys" @click="() => setChartData(key)">{{ key }}</button>

  <div style="height:200px;margin-top: 2rem;">
    <span v-for="l in labels" style="margin-right: 20px" v-html="getIcon(l)"></span>
  </div>

  <VisXYContainer :data="chartData" :height="height">
    <VisStackedBar :x="(d: any) => d.year" :y="labels.map((l: any) => (d: any) => d[l.format])" />
    <VisCrosshair :template="tooltipTemplate" />
    <VisTooltip :verticalShift="height" :horizontalPlacement="Position.Center" />
    <VisAxis type="x" />
  </VisXYContainer>
</template>
