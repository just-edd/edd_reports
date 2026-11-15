<script lang="ts">
import Chat from "$lib/components/Chat.svelte";
import NewReport from "$lib/components/NewReport.svelte";
import { slideWidth } from "$lib/transitions/transitions";
import type { ReportData } from "$lib/types/report";

let report: ReportData | null = $state(null);
</script>

<div class="absolute top-1/2 -translate-y-1/2 flex items-stretch">
    <NewReport oncreated={(reportData: ReportData | null) => (report = reportData)} {report} />

    {#if report !== null}
        <div class="flex items-stretch ml-5" transition:slideWidth={{ duration: 400, gap: 20 }}>
            <Chat {report} />
        </div>
    {/if}
</div>