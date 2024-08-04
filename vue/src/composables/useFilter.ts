import type { Ref } from 'vue'
import {PrisonerRecord} from "@/@types/types";

export function useFilter(): {
    checkPrisonerFilter: (prisoner: PrisonerRecord, buttonFilter: Ref<string>, cleanFilterObject?: Record<any, any>, nameSearch?: Ref<string>) => boolean
} {


    const fieldFiltersRel: Record<string, keyof PrisonerRecord> = {
        ideology: 'Ideologies',
        affiliation: 'Affiliation',
        era: 'Era',
        state: 'State',
        race: 'Race',
        gender: 'Gender'
    }


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

    const checkPrisonerFilter = (prisoner: PrisonerRecord, buttonFilter: Ref<string>, cleanFilterObject?: Record<any, any>, nameSearch?: Ref<string>): boolean => {
        const _filters: Record<any, any>|null = cleanFilterObject  ? cleanFilterObject.value : null

        let recordFilterFailed = false

        if(buttonFilter.value && !prisoner[buttonFilter.value]) {
            return false
        }

        if(nameSearch && nameSearch.value) {
            const nameSearchLower = nameSearch.value.toLowerCase();
            const prisonerNameLower = prisoner.name.toLowerCase();
            const prisonerAKALower = prisoner.AKA?.toLowerCase();

            if (!prisonerNameLower.includes(nameSearchLower) && !prisonerAKALower?.includes(nameSearchLower)) {
                return false;
            }
        }


        if(!_filters) return true

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
    return { checkPrisonerFilter }
}
