<template>
  <section id="prisoners-page" class="bg-black text-white py-12">
    <div class="container mx-auto">

      <a-radio-group v-model:value="buttonFilter">
        <a-radio-button value="imprisonedOrExiled">In Custody or Exiled</a-radio-button>
        <a-radio-button value="">All Cases</a-radio-button>
        <a-radio-button value="inExile">In Exile</a-radio-button>
        <a-radio-button value="inCustody">In Custody</a-radio-button>
        <a-radio-button value="released">Released</a-radio-button>
        <a-radio-button value="awaitingTrial">Awaiting Trial</a-radio-button>
      </a-radio-group>

      <input type="search" placeholder="Search by name" v-model="nameSearch"/>

      <PrisonerFilters class="mb-12" :filters="filterFieldsObj" v-model:model-value="filterObject"/>
      <template v-for="record in filteredRecords" >
        <PrisonerCard v-if="!record['Status Under Review']" :record="record" :key="record.id" />
      </template>
    </div>
  </section>
</template>

<script lang="ts" async setup>
import useAirtable from './composables/useAirtable';
import PrisonerCard from "@/PrisonerCard.vue";
import PrisonerFilters from "@/PrisonerFilters.vue";
import {ref, watch, computed, onMounted, onUnmounted} from "vue";
import {PrisonerRecord} from "@/types";
const { records, fetchRecords, filterFieldsObj } = useAirtable();
await fetchRecords();
const filterObject = ref<any>({});
const cleanFilterObject = ref<any>({});
const nameSearch = ref<string>('');
const buttonFilter = ref<string>('imprisonedOrExiled')

const fieldFiltersRel: Record<string, keyof PrisonerRecord> = {
  ideology: 'Ideologies',
  affiliation: 'Affiliation',
  era: 'Era',
  state: 'State',
  race: 'Race',
  gender: 'Gender'
}



// Computed property to generate filtered records
const filteredRecords = computed(() => {
  console.log('Filtering')
  return records.value.filter((record) => {
    const filterCheck = checkPrisonerFilter(record)
    if(record.name.includes('Jessica')) {
      console.log(record.name, filterCheck)
    }
    return filterCheck
  });
});



watch(filterObject, (newValue, oldValue) => {
  const _filters: Record<string, string[]> = {}
  Object.keys(filterObject.value).forEach((key) => {
    const value = filterObject.value[key]
    if(value && value.length > 0) {
      _filters[key] = value
    }
  })

  cleanFilterObject.value = _filters
}, { deep: true });


const checkFilterValues = (filterValues: string[], prisonerValue: string | string[]): boolean => {
  // Convert everything to lowercase to make the comparison case-insensitive (optional)
  const lowerFilterValues = filterValues.map(value => value.toLowerCase());

  if (typeof prisonerValue === 'string') {
    // If prisonerValue is a string, we check if any filterValue matches prisonerValue
    return lowerFilterValues.includes(prisonerValue.toLowerCase());
  } else if (Array.isArray(prisonerValue)) {
    // If prisonerValue is an array, we check if any filterValue is included in prisonerValue
    const lowerPrisonerValue = prisonerValue.map(value => value.toLowerCase());
    return lowerFilterValues.some(value => lowerPrisonerValue.includes(value));
  }

  return false; // Fallback case, shouldn't be reached
};

const checkPrisonerFilter = (prisoner: PrisonerRecord): boolean => {
  const _filters = cleanFilterObject.value

  let recordFilterFailed = false

  // @ts-ignore
  if(buttonFilter.value && !prisoner[buttonFilter.value]) {
    return false
  }

  if(nameSearch.value) {
    const nameSearchLower = nameSearch.value.toLowerCase();
    const prisonerNameLower = prisoner.name.toLowerCase();
    const prisonerAKALower = prisoner.AKA?.toLowerCase();

    if (!prisonerNameLower.includes(nameSearchLower) && !prisonerAKALower?.includes(nameSearchLower)) {
      return false;
    }
  }

  Object.keys(_filters).forEach((key) => {
    const field = fieldFiltersRel[key]
    // @ts-ignore
    const prisonerValue: string|Array<string> = prisoner[field]
    const filterValues = _filters[key]
    if(!prisonerValue) {
      recordFilterFailed = true
    }

    if(prisoner.name.includes('Jessica')) {
      console.log({field,prisonerValue,filterValues})
    }

    if(!prisonerValue || !filterValues.length) return false


    const matchesFilter = checkFilterValues(filterValues, prisonerValue)

    if(!matchesFilter) recordFilterFailed = true
  })

  // Returns true to show
  return !recordFilterFailed
}
</script>

<style lang="scss">
#prisoners-page {

  .container {
    max-width: 1024px;
    padding: 0 1rem;
    margin: 0 auto;
  }
}

.ant-radio-group {
  display: flex;
  justify-content: center;
  margin: 0 -5px 2rem;

  @media only screen and (max-width: 768px) {
    display: block;
    padding: 0 8px;
  }


  label {

    span {
      display: block;
      text-align: center;
      width:100%
    }

    .ant-radio-button {
      display:none
    }
  }
}

.ant-radio-button-wrapper {
  border: none !important;
  border-radius: 0 !important;
  background: #FFF;
  color: #000 !important;
  margin: 0 3px;
  outline: none !important;
  box-shadow: none !important;
  flex-grow: 1;
  height: 50px;
  line-height: 50px;
  font-size: 14px;


  @media only screen and (max-width: 768px) {
    width: 100%;
    margin: 0 0 5px;
  }

  &.ant-radio-button-wrapper-checked {
    background: #5660fe;
    color:#FFF !important;
  }
}


input[type=search] {
  background: #FFF;
  border: none;
  border-radius: 0;
  min-height: 37px;
  outline: none;
  color:#000;
  width:100%;
  display:block;
  margin-bottom: .5rem;
  padding: 0 .5rem;
}
</style>
