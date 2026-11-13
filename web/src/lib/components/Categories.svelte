<script lang="ts">
    import { t } from '$lib/store/locale';

    const types = [
        { id: 'player', icon: 'hgi-user-02' },
        { id: 'bug', icon: 'hgi-bug-02' },
        { id: 'question', icon: 'hgi-message-circle-question-mark' },
    ] as const;

    let selected = $state(0);
</script>

<div class="relative w-full bg-white/5 bevel p-1 flex items-center" style="--bevel: 8px;">
    <!-- Slider -->
    <div
        class="absolute top-1 bottom-1 left-1 bg-black bevel transition-transform duration-300 ease-out"
        style="
            --bevel: 6px;
            width: calc((100% - 0.5rem) / {types.length});
            transform: translateX({selected * 100}%);
        "
    ></div>

    {#each types as type, i}
        <button
            class="relative z-10 flex flex-1 items-center justify-center gap-2 py-1 transition-colors duration-300
                   {selected === i ? 'text-white' : 'text-zinc-400 hover:text-zinc-300'}"
            onclick={() => (selected = i)}
        >
            <i class="hgi hgi-stroke hgi-rounded {type.icon}"></i>
            <p class="text-[15px] font-medium">{$t(type.id)}</p>
        </button>
    {/each}
</div>