<script lang="ts">
import { useNuiEvent } from "$lib/hooks/useNuiEvents";
import type { Message } from "$lib/types/chat";
import type { ReportData } from "$lib/types/report";
import { fetchNui } from "$lib/utils/fetchNui";
import { tick } from "svelte";

let { report }: { report: ReportData } = $props();

let messages = $state<Message[]>([]);
let input: string = $state('');
let list: HTMLDivElement;
let sending = $state(false);

async function scrollDown(smooth = true) {
    await tick();
    list?.scrollTo({ top: list.scrollHeight, behavior: smooth ? 'smooth' : 'auto' });
}

async function send() {
    
}

// Helper functions for UI chat bubbles
function bevels(msg: Message, i: number, total: number) {
    const first = i === 0;
    const last = i === total - 1;

    return [
        msg.isMine ? 'bevel-tl bevel-bl' : 'bevel-tr bevel-br',
        first && (msg.isMine ? 'bevel-tr' : 'bevel-tl'),
        last && (msg.isMine ? 'bevel-br' : 'bevel-bl')
    ].filter(Boolean).join(' ');
}

function formatTime(timestamp: number) {
    return new Date(timestamp * 1000).toLocaleString('en-GB', {
        day: '2-digit', month: 'short', minute: '2-digit', hour: '2-digit'
    });
}
</script>

<div class="flex flex-col gap-3 w-[600px]" style="--bevel: 12px">
    <div class="flex items-center justify-between">
        <div>
            <h1 class="text-4xl font-semibold leading-none">CHAT</h1>
            <p class="text-[17px] leading-none text-gray-300">Here you can communicate with admin team.</p>
        </div>

        <div class="flex items-center gap-5">
            <div class="flex flex-col justify-center items-end">
                <p class="text-sm leading-tight">CREATED AT</p>
                <p class="text-gray-200 leading-none bg-gray-500/75 px-2 py-0.5 bevel text-[15px]" style="--bevel: 5px">{formatTime(report.createdAt)}</p>
            </div>

            <div class="flex flex-col justify-center items-end">
                <p class="text-sm leading-tight">REPORT ID</p>
                <p class="text-gray-200 leading-none bg-gray-500/75 px-2 py-0.5 bevel text-[15px]" style="--bevel: 5px">#{String(report.reportId).padStart(3, '0')}</p>
            </div>
        </div>
    </div>

    <div class="w-4/5 h-1 bg-white/25 -skew-x-[45deg]"></div>

    <div class="bg-white/15 h-full bevel-top p-3 flex flex-col gap-2 overflow-y-auto" bind:this={list}>
        {#each messages as msg, index}
            <div 
                class="flex flex-col max-w-[80%] w-fit bg-black/65 px-3 py-1.5 chat-box {msg.isMine ? "self-end items-end" : "self-start items-start"}
                {bevels(msg, index, messages!.length)}"
            >
                <div class="flex w-full items-center justify-between gap-4">
                    <div class="flex items-center gap-2 font-semibold">
                        {#if msg.isStaff}
                            <i class="hgi hgi-stroke hgi-rounded hgi-shield-user gradient-title"></i>
                        {/if}

                        <p>{msg.author}</p>

                        {#if msg.role}
                            <p class="font-normal text-[13px] bg-gray-500/40 px-2 bevel" style="--bevel: 5px">{msg.role.toUpperCase()}</p>
                        {/if}
                    </div>
                    <p class="text-sm text-gray-300">{formatTime(msg.time)}</p>
                </div>

                <p class="break-words leading-tight">{msg.text}</p>
            </div>
        {/each}
    </div>

    <div class="bg-white/15 bevel-bottom px-4 py-2">
        <input 
            type="text"
            maxlength="300"
            class="w-full h-full bg-transparent focus:outline-none placeholder:text-gray-300"
            placeholder="Type..."
            bind:value={input}
            onkeydown={(e) => e.key === 'Enter' && send()}
        >
    </div>
</div>