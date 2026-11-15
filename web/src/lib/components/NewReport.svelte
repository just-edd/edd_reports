<script lang="ts">
import type { ReportData } from "$lib/types/report";
import { fetchNui } from "$lib/utils/fetchNui";
import { scale } from "svelte/transition";

let { oncreated, report }: { oncreated: (report: ReportData | null) => void, report: ReportData | null } = $props();

let titleInput: string = $state('');
let descriptionInput: string = $state('');
let linkInput: string = $state('');

// REPORT CATEGORIES
let selectedCategory: string = $state('player');
let reportCategories: { label: string, icon: string, id: string }[] = [
    { label: 'Player', icon: 'hgi-user-03', id: 'player' },
    { label: 'Bug', icon: 'hgi-bug-01', id: 'bug' },
    { label: 'Question', icon: 'hgi-message-circle-question-mark', id: 'question' }
]
let selectedIndex = $derived(reportCategories.findIndex((c) => c.id === selectedCategory));

// REPORT PRIORITIES
let selectedPriority: string = $state('low');
let reportPriorities = [ 'Low', 'Medium', 'High', 'Urgent' ];
let selectedPriorityIndex = $derived(reportPriorities.findIndex((p) => p.toLowerCase() === selectedPriority));

async function createReport() {
    const title = titleInput.trim();
    if (!title) return;

    const payload = {
        title,
        description: descriptionInput.trim(),
        link: linkInput.trim(),
        priority: selectedPriority,
        category: selectedCategory,
    };

    const report = await fetchNui<ReportData>('create_report', payload, {
        data: { ...payload, createdAt: Math.floor(Date.now() / 1000), reportId: Math.floor(Math.random() * (1000 - 1 + 1)) + 1 , createdBy: 'johhn',
            messages: [{ author: 'SERVER', isStaff: true, isMine: false, text: "Admin team will get to you as soon as possible. Please wait until then.", time: Math.floor(Date.now() / 1000) }]
        }
    });

    if (report?.reportId != null) oncreated(report);
}

async function deleteReport() {
    const success = await fetchNui<boolean>('delete_report', report?.reportId, {
        data: true
    });

    if (success) {
        titleInput = '';
        descriptionInput = '';
        linkInput = '';
        selectedCategory = 'player';
        selectedPriority = 'low';

        oncreated(null);
    }
}
</script>

<div class="flex flex-col justify-center gap-3 w-[600px]" style="--bevel: 10px" transition:scale>
    <div>
        <h1 class="text-4xl font-semibold leading-none">REPORT <span class="gradient-title drop-shadow-[0_0_10px_#8acf22]">SYSTEM</span></h1>
        <p class="text-[17px] text-gray-300 leading-none">Need help? Feel free to contact us via this form.</p>
    </div>
            
    <div class="w-4/5 h-1 bg-white/25 -skew-x-[45deg]"></div>

    <div class="p-1 bg-white/20 relative flex items-center bevel-top">
        <div
            class="absolute top-1 bottom-1 left-1 bg-gradient-to-br from-[#8acf22a0] to-[#caf388a0]
                transition-transform duration-300 ease-out category-slider"
            class:first={selectedIndex === 0}
            class:last={selectedIndex === reportCategories.length - 1}
            style="width: calc((100% - 0.5rem) / {reportCategories.length});
                transform: translateX({selectedIndex * 100}%);"
        ></div>

        {#each reportCategories as category}
            <button class="z-10 flex items-center gap-2 w-full justify-center py-1 font-medium"
            onclick={() => selectedCategory = category.id} disabled={report !== null}>
                <i class="hgi hgi-stroke hgi-rounded {category.icon}"></i>
                <p>{category.label}</p>
            </button>
        {/each}
    </div>

    <div>
        <p class="text-lg">Title <span class="text-gray-400 text-sm">(*)</span></p>
        <div class="bg-white/15">
            <input 
                type="text" 
                class="w-full h-full bg-transparent focus:outline-none px-2.5 py-2 placeholder:text-gray-300" 
                placeholder="What is your problem?"
                required
                bind:value={titleInput}
                disabled={report !== null}
            >
        </div>
    </div>

    <div>
        <p class="text-lg">Description <span class="text-gray-400 text-sm">(optional)</span></p>
        <div class="bg-white/15">
            <textarea
                rows="5"
                class="w-full h-full bg-transparent focus:outline-none px-2.5 py-2 placeholder:text-gray-300 resize-none" 
                placeholder="Tell us more about your problem..."
                bind:value={descriptionInput}
                disabled={report !== null}
            ></textarea>
        </div>
    </div>

    <div>
        <p class="text-lg">Additional links <span class="text-gray-400 text-sm">(optional)</span></p>
        <div class="bg-white/15">
            <input 
                type="text"
                class="w-full h-full bg-transparent focus:outline-none px-2.5 py-2 placeholder:text-gray-300" 
                placeholder="Enter url of additional prove"
                bind:value={linkInput}
                disabled={report !== null}
            >
        </div>
    </div>

    <div>
        <p class="text-lg">Priority <span class="text-gray-400 text-sm">(*)</span></p>
        <div class="p-1 bg-white/20 relative flex items-center">
            <div
                class="absolute top-1 bottom-1 left-1 bg-gradient-to-br from-[#8acf22a0] to-[#caf388a0]
                    transition-transform duration-300 ease-out"

                style="width: calc((100% - 0.5rem) / {reportPriorities.length});
                    transform: translateX({selectedPriorityIndex * 100}%);"
            ></div>

            {#each reportPriorities as priority}
                <button class="z-10 flex items-center gap-2 w-full justify-center py-1 font-medium" disabled={report !== null}
                    onclick={() => selectedPriority = priority.toLowerCase()}>
                    {priority}
                </button>
            {/each}
        </div>
    </div>

    <div class="w-full bg-white/15 flex items-center justify-center bevel-bottom p-1">
        <button class="py-2 hover:bg-gradient-to-br from-[{report !== null ? '#fca5a5a0' : '#caf388a0'}] to-[{report !== null ? '#ef4444a0' : '#84cc16a0'}] flex items-center justify-center gap-2 w-full bevel-bottom"
            onclick={report !== null ? deleteReport : createReport}>
            <i class="hgi hgi-stroke hgi-rounded {report !== null ? 'hgi-trash' : 'hgi-send'}"></i>
            <p>{report !== null ? 'Delete report' : 'Send report'}</p>
        </button>
    </div>
</div>