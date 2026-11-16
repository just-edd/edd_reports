<script lang="ts">
type Props = {
    label: string;
    icon: string;
    value: string;
    placeholder?: string;
    rows?: number
}

let { label, icon, value = $bindable(''), placeholder, rows }: Props = $props();

const inputClass = "block w-full bg-transparent focus:outline-none placeholder:text-zinc-400";
</script>

<label class="block">
    <span class="flex items-center gap-1">
        <i class="hgi hgi-stroke hgi-rounded {icon}"></i>
        {label}
    </span>

    <span class="relative bevel block bg-gray-950/75 px-3 py-1.5 focus-within:[--border-color:#65a30d]" style="--bevel: 6px">
        {#if rows}
            <textarea {rows} {placeholder} bind:value class="{inputClass} resize-none"></textarea>
        {:else}
            <input type="text" {placeholder} bind:value class={inputClass} />
        {/if}
    </span>
</label>