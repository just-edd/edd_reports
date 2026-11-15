<script lang="ts">
import Chat from "$lib/components/Chat.svelte";
import NewReport from "$lib/components/NewReport.svelte";
import { slideWidth } from "$lib/transitions/transitions";
import type { ReportData } from "$lib/types/report";
import { isEnvBrowser } from "$lib/utils/misc";
import { fade } from "svelte/transition";

let visible = $state(true);
let report: ReportData | null = $state(null);

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
        <div class="absolute top-1/2 -translate-y-1/2 flex items-stretch">
            <NewReport oncreated={(reportData: ReportData | null) => (report = reportData)} {report} />

            {#if report !== null}
                <div class="flex items-stretch ml-5" transition:slideWidth={{ duration: 400, gap: 20 }}>
                    <Chat {report} />
                </div>
            {/if}
        </div>
    </div>
{/if}