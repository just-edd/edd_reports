<script lang="ts">
interface Option {
    id: string;
    label: string;
    icon?: string;
    color?: string; // default lime
}

type Props = {
    options: readonly Option[];
    value: string;
};

let { options, value = $bindable() }: Props = $props();

const activeIndex = $derived(Math.max(0, options.findIndex((o) => o.id === value)));
const activeColor = $derived(options[activeIndex]?.color ?? "#65a30d");
</script>

<div class="relative flex w-full items-center bg-gray-950/75 p-1 bevel" style="--bevel: 6px">
    <div
        class="pointer-events-none absolute inset-y-1 left-1 bevel bg-gradient-to-r
               from-[color-mix(in_srgb,var(--border-color)_30%,transparent)] to-transparent
               transition-transform duration-300 ease-out"
        style="--bevel: 5px;
               --border-color: {activeColor};
               width: calc((100% - 0.5rem) / {options.length});
               transform: translateX({activeIndex * 100}%)"
    ></div>

    {#each options as option (option.id)}
        <button
            type="button"
            aria-pressed={value === option.id}
            class="relative z-10 flex w-full items-center justify-center gap-2 py-1 transition-colors
                   {value === option.id ? 'text-white' : 'text-zinc-400 hover:text-white'}"
            onclick={() => (value = option.id)}
        >
            {#if option.icon}<i class="hgi hgi-stroke hgi-rounded {option.icon} text-lg"></i>{/if}
            {option.label}
        </button>
    {/each}
</div>