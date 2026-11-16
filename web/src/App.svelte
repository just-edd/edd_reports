<script lang="ts">
import SegmentedControl from "$lib/components/SegmentedControl.svelte";
import TextField from "$lib/components/TextField.svelte";
import { CATEGORIES, PRIORITIES } from "$lib/constants/categories";
import { useNuiEvent } from "$lib/hooks/useNuiEvents";
import { fetchNui } from "$lib/utils/fetchNui";
import { isEnvBrowser } from "$lib/utils/misc";
import { fade } from "svelte/transition";

let visible = $state(true);
let form = $state({
    category: CATEGORIES[0].id,
    title: '',
    description: '',
    link: '',
    priority: PRIORITIES[0].id
});

useNuiEvent('close', () => {
    visible = false;
});

if (isEnvBrowser()) {
    const root = document.getElementById('app');

    // https://i.imgur.com/iPTAdYV.png - Night time img
    root!.style.backgroundImage = 'url("https://i.imgur.com/3pzRj9n.png")';
    root!.style.backgroundSize = 'cover';
    root!.style.backgroundRepeat = 'no-repeat';
    root!.style.backgroundPosition = 'center';
};

let activeCategory = $state(CATEGORIES[0].id);
const activeCategoryIndex = $derived(CATEGORIES.findIndex((category) => category.id === activeCategory));
let activePriority = $state(PRIORITIES[0].id);
const activePriorityIndex = $derived(PRIORITIES.findIndex((priority) => priority.id === activePriority));

function onKeyDown(event: KeyboardEvent) {
    const key = event.key.toLowerCase();

    switch (key) {
        case 'escape':
            return fetchNui('close')
    }
}
</script>

<svelte:window onkeydown={onKeyDown} />

{#if visible}
    <div class="wrapper" transition:fade>
        <div class="w-[500px] flex flex-col gap-3">
            <div class="flex items-center justify-between">
                <div>
                    <h1 class="text-3xl font-medium leading-none">REPORT <span class="gradient-title drop-shadow-[0_0_15px_#84cc16]">SYSTEM</span></h1>
                    <p class="text-gray-300 leading-none">Need help? Feel free to contact admin team.</p>
                </div>

                <div class="flex items-center bg-gray-950/75 p-1 text-sm bevel" style="--bevel: 6px">
                    <p class="bg-gray-700 px-2 bevel" style="--bevel: 5px">ESC</p>
                    <p class="px-2">EXIT</p>
                </div>
            </div>

            <div class="h-1.5 w-2/3 bg-white/15 -skew-x-[45deg]"></div>

            <SegmentedControl options={CATEGORIES} bind:value={form.category} />

            <TextField label="Report Title" icon="hgi-subtitle" bind:value={form.title}
                placeholder="What is the title of your problem?" />

            <TextField label="Report Description" icon="hgi-pen-02" bind:value={form.description}
                rows={4} placeholder="Tell us more about your problem..." />

            <TextField label="Additional links" icon="hgi-link-04" bind:value={form.link}
                placeholder="https://medal.tv" />

            <div>
                <p class="flex items-center gap-1">
                    <i class="hgi hgi-stroke hgi-rounded hgi-medium-signal"></i>
                    Report Priority
                </p>
                <SegmentedControl options={PRIORITIES} bind:value={form.priority} />
            </div>

            <button 
                class="relative bg-gray-950/75 flex items-center justify-center gap-2 py-2 bevel text-zinc-400 transition-colors 
                    hover:text-white hover:bg-gradient-to-r hover:from-lime-300/30 hover:[--border-color:#65a30d]" 
                style="--bevel: 6px;">
                <i class="hgi hgi-stroke hgi-rounded hgi-send"></i>
                <p>Send Report</p>
            </button>
        </div>
    </div>
{/if}