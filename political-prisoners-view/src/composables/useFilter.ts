import { ref, computed } from 'vue';

export default function useFilter(initialData: any[]) {
    const searchTerm = ref('');

    const filteredData = computed(() => {
        return initialData.filter((item: any) => {
            return item.name.toLowerCase().includes(searchTerm.value.toLowerCase());
        });
    });

    return { searchTerm, filteredData };
}
