<script lang="ts">
import { useNuiEvent } from '$lib/hooks/useNuiEvents';
import { setLocale } from '$lib/store/locale';
import { isEnvBrowser } from '$lib/utils/misc';
import { t } from '$lib/store/locale';
import '$lib/debug/mock';
import Categories from '$lib/components/Categories.svelte';

useNuiEvent<{
    locale: { [key: string]: string };
}>('init', ({ locale }) => {
    setLocale(locale);
});

if (isEnvBrowser()) {
    const root = document.getElementById('app');

    // https://i.imgur.com/iPTAdYV.png - Night time img
    root!.style.backgroundImage = 'url("https://i.imgur.com/3pzRj9n.png")';
    root!.style.backgroundSize = 'cover';
    root!.style.backgroundRepeat = 'no-repeat';
    root!.style.backgroundPosition = 'center';
}

function onKeyDown(event: KeyboardEvent) {
    const key = event.key.toLowerCase();

    switch (key) {
        // Key handlers
    }
}
</script>

<!-- Main container for report system -->
<div class="container bevel flex flex-col gap-3" style="--bevel: 12px;">
    <div class="flex items-center justify-between">
        <div>
            <h1 class="text-white font-bold text-xl uppercase font-[Montserrat]">{$t('new_report')}</h1>
            <p class="text-zinc-500 text-sm">{$t('report_description')}</p>
        </div>
        <div class="relative flex items-center gap-2 p-0.5 text-sm text-zinc-400
            before:absolute before:inset-0 before:-z-10 before:-skew-x-[20deg] before:bg-white/10">
            <p class="relative px-1.5 before:absolute before:inset-0 before:-z-10 before:-skew-x-[20deg] before:bg-white/15">ESC</p>
            <div class="px-1.5 flex items-center gap-1">
                <i class="hgi hgi-stroke hgi-rounded hgi-square-arrow-right-exit"></i>
                {$t('exit')}
            </div>
        </div>
    </div>

    <Categories />

    <div class="flex flex-col gap-1.5">
        <p class="text-white text-sm bevel px-2 bg-white/10 w-fit " style="--bevel: 6px">{$t('title')}</p>
        <input type="text" placeholder="{$t('title_placeholder')}" 
            class="w-full py-2 px-3 bevel bg-black/35 text-white text-sm placeholder:text-zinc-400 font-[Roboto]" 
            style="--bevel: 7px"
        />
    </div>

    <div class="flex flex-col gap-1.5 ">
        <p class="text-white text-sm bevel px-2 bg-white/10 w-fit" style="--bevel: 6px">{$t('description')}</p>
        <textarea placeholder="{$t('description_placeholder')}" rows="5" 
            class="w-full py-2 px-3 bevel bg-black/35 text-white text-sm placeholder:text-zinc-400 resize-none font-[Roboto]" 
            style="--bevel: 7px"
        ></textarea>
    </div>

    <button class="flex items-center justify-center gap-2 text-black bg-white bevel py-1 mt-2 hover:bg-white/80 duration-200" style="--bevel: 5px">
        <i class="hgi hgi-stroke hgi-rounded hgi-send"></i>
        <p class="font-[Roboto] text-[15px]">{$t('create_report')}</p>
    </button>
</div>