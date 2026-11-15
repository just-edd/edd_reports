<script lang="ts">
import Chat from "$lib/components/Chat.svelte";
import NewReport from "$lib/components/NewReport.svelte";
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
        <div class="absolute top-1/2 -translate-y-1/2 flex items-stretch gap-10">
            <NewReport />
            <Chat />
        </div>
    </div>
{/if}