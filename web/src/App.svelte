<script lang="ts">
import { isEnvBrowser } from "$lib/utils/misc";
import { fade } from "svelte/transition";

let visible = $state(true);

if (isEnvBrowser()) {
    const root = document.getElementById('app');

    // https://i.imgur.com/iPTAdYV.png - Night time img
    root!.style.backgroundImage = 'url("https://i.imgur.com/3pzRj9n.png")';
    root!.style.backgroundSize = 'cover';
    root!.style.backgroundRepeat = 'no-repeat';
    root!.style.backgroundPosition = 'center';
}

let selectedCategory: string = $state('player');
let reportCategories: { label: string, icon: string, id: string }[] = [
    { label: 'Player', icon: 'hgi-user-03', id: 'player' },
    { label: 'Bug', icon: 'hgi-bug-01', id: 'bug' },
    { label: 'Question', icon: 'hgi-message-circle-question-mark', id: 'question' }
]
let selectedIndex = $derived(
    reportCategories.findIndex((c) => c.id === selectedCategory)
);
</script>

{#if visible}
    <div class="wrapper" transition:fade>
        <div class="flex flex-col justify-center absolute top-1/2 left-1/3 -translate-x-1/2 -translate-y-1/2 gap-3 w-[600px]">
            <div>
                <h1 class="text-4xl font-semibold leading-none">REPORT <span class="gradient-title">SYSTEM</span></h1>
                <p class="text-[17px] text-gray-300 leading-none">Need help? Feel free to contact us via this form.</p>
            </div>
            
            <div class="w-4/5 h-1 bg-white/25 -skew-x-[45deg]"></div>

            <div class="p-1 bg-white/20 -skew-x-[15deg] relative flex items-center">
                <div
                    class="absolute top-1 bottom-1 left-1 bg-gradient-to-br from-[#caf388a0] to-[#84cc16a0]
                        transition-transform duration-300 ease-out"
                    style="width: calc((100% - 0.5rem) / {reportCategories.length});
                        transform: translateX({selectedIndex * 100}%);"
                ></div>

                {#each reportCategories as category}
                    <button class="relative z-10 flex items-center gap-2 w-full justify-center py-1 font-medium"
                    onclick={() => selectedCategory = category.id}>
                        <i class="hgi hgi-stroke hgi-rounded {category.icon} skew-x-[15deg] will-change-transform [backface-visibility:hidden] antialiased"></i>
                        <p class="skew-x-[15deg] will-change-transform [backface-visibility:hidden] antialiased">{category.label}</p>
                    </button>
                {/each}
            </div>

            <div>
                <p class="text-lg">Title</p>
                <div class="bg-white/15 -skew-x-[15deg]">
                    <input 
                        type="text" 
                        class="w-full h-full bg-transparent focus:outline-none px-2.5 py-2 placeholder:text-gray-300 skew-x-[15deg]" 
                        placeholder="What is your problem?"
                    >
                </div>
            </div>

            <div>
                <p class="text-lg">Description</p>
                <div class="bg-white/15 rounded-sm">
                    <textarea
                        rows="5"
                        class="w-full h-full bg-transparent focus:outline-none px-2.5 py-2 placeholder:text-gray-300 resize-none" 
                        placeholder="Tell us more about your problem..."
                        
                    ></textarea>
                </div>
            </div>

            <button class="bg-white/15 py-2 hover:bg-gradient-to-br from-[#caf388a0] to-[#84cc16a0] flex items-center justify-center gap-2">
                <i class="hgi hgi-stroke hgi-rounded hgi-send"></i>
                <p>Send report</p>
            </button>
        </div>
    </div>
{/if}