import { Ref, ref, watchEffect } from 'vue';
import axios from 'axios';
import { Case, CaseFields, Institution, Prisoner, PrisonerFilters, PrisonerRecord } from "@/types";

export default function useAirtable() {
    const filterFieldsObj: PrisonerFilters = {
        ideology: [],
        era: [],
        affiliation: [],
        state: [],
        race: [],
        gender: []
    }


    const records: Ref<PrisonerRecord[]> = ref([]);
    const filterFields: Ref<PrisonerFilters> = ref(filterFieldsObj)



    // Function to update filter arrays, remove duplicates, and sort
    const updateFilterArray = (array: string[], value: string | string[]) => {
        if (Array.isArray(value)) {
            array.push(...value);
        } else {
            array.push(value);
        }
        // Remove duplicates
        const uniqueArray = Array.from(new Set(array));
        // Sort alphabetically
        return uniqueArray.sort();
    };


    const fetchRecords = async () => {
        const req = await axios.get(`https://marisam-airtable.patrickdeamorim.workers.dev/`)
        const prisoners: Prisoner[] = req.data

        if (!prisoners.length) {
            throw new Error('No prisoners')
        }

        prisoners.forEach((prisoner: Prisoner) => {
            filterFieldsObj.ideology = updateFilterArray(filterFieldsObj.ideology, prisoner.Ideologies ?? []);
            filterFieldsObj.affiliation = updateFilterArray(filterFieldsObj.affiliation, prisoner.Affiliation ?? []);
            filterFieldsObj.era = updateFilterArray(filterFieldsObj.era, prisoner.Era ?? '');
            filterFieldsObj.state = updateFilterArray(filterFieldsObj.state, prisoner.State ?? '');
            filterFieldsObj.race = updateFilterArray(filterFieldsObj.race, prisoner.Race ?? '');
            filterFieldsObj.gender = updateFilterArray(filterFieldsObj.gender, prisoner.Gender ?? '');


            // Parse prisoner
            const prisonerId: string = prisoner.id
            const prisonerRecord: PrisonerRecord = {
                ...prisoner,
                imprisonedOrExiled: prisoner['Imprisoned or Exiled'] === 'T',
                visible: true
            }

            const mainCase = prisoner.cases[0]
            if (mainCase) {
                prisonerRecord.released = prisoner["Released"]
                prisonerRecord.awaitingTrial = prisoner["Awaiting Trial"]
                prisonerRecord.inCustody = prisoner["In Custody"]
                prisonerRecord.inExile = prisoner['In Exile']
            }


            records.value.push(prisonerRecord)
        })

    }


    return { records, fetchRecords, filterFieldsObj };
}
