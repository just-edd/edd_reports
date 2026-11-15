<script lang="ts">
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
let selectedPriorityIndex = $derived(reportPriorities.findIndex((c) => c.toLowerCase() === selectedPriority));
</script>

<div class="flex flex-col justify-center gap-3 w-[600px]" style="--bevel: 10px">
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
            onclick={() => selectedCategory = category.id}>
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
                <button class="z-10 flex items-center gap-2 w-full justify-center py-1 font-medium"
                    onclick={() => selectedPriority = priority.toLowerCase()}>
                    {priority}
                </button>
            {/each}
        </div>
    </div>

    <div class="w-full bg-white/15 flex items-center justify-center bevel-bottom p-1">
        <button class="py-2 hover:bg-gradient-to-br from-[#caf388a0] to-[#84cc16a0] flex items-center justify-center gap-2 w-full bevel-bottom">
            <i class="hgi hgi-stroke hgi-rounded hgi-send"></i>
            <p>Send report</p>
        </button>
    </div>
</div>