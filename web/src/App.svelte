<script lang="ts">
import ReportMenu from "$lib/components/ReportMenu.svelte";
import { useNuiEvent } from "$lib/hooks/useNuiEvents";
import MainReport from "$lib/pages/MainReport.svelte";
import type { ReportData } from "$lib/types/report";
import { debugData } from "$lib/utils/debugData";
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
</script>

{#if visible}
    <div class="wrapper" transition:fade>
        <ReportMenu />
    </div>
{/if}