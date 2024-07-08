import {CaseFields, Prisoner} from "@/@types/types";

interface PrisonerFieldGroups {
    title: string;
    fieldKey: keyof Prisoner;
}

interface CaseCardFields {
    title?: string;
    fieldKey: keyof CaseFields;
    separator?: boolean
    asTags?: boolean
}
export const caseCardFields: CaseCardFields[] = [
    { title: 'Arrested', fieldKey: "Arrest Date" },
    { title: 'Indicted', fieldKey: "Indicted" },
    { title: 'Convicted', fieldKey: "Convicted" },
    { title: 'Sentenced', fieldKey: "Sentenced Date" },
    { title: 'Released', fieldKey: "Release Date" },
    { title: 'Charges', fieldKey: "Charges", asTags: true },
    { title: 'Prosecutor', fieldKey: "Prosecutor" },
    { title: 'Judge', fieldKey: "Judge" },
    { title: 'Plead', fieldKey: "Plead" },
    { title: 'Sentence', fieldKey: "Sentence" },
    { title: 'Institution Name', fieldKey: "Institution name" },
    { title: 'Institution City', fieldKey: "Institution city" },
    { title: 'State', fieldKey: "Institution state" },
    { title: 'Institution Security', fieldKey: "Institution security" },
]

export const prisonerCardFields: PrisonerFieldGroups[] = [
    { title: 'Age', fieldKey: 'Age' },
    { title: 'Gender', fieldKey: 'Gender' },
    { title: 'Race', fieldKey: 'Race' },
    { title: 'Birthday', fieldKey: 'Birthdate' },
    { title: 'Affiliation', fieldKey: 'Affiliation' },
];
