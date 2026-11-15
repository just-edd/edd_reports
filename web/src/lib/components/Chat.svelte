<script lang="ts">
import type { Message } from "$lib/types/chat";

let messages = $state<Message[]>([
    // DEV
    {
        id: 0,
        author: 'edd',
        isStaff: true,
        isMine: false,
        text: 'Hello, I\'ll get to you as soon as possible. Please wait a minute.',
        time: '15.11.2026 14:35'
    },
    {
        id: 1,
        author: 'johhn',
        isStaff: false,
        isMine: true,
        text: 'OK. No problem, I\'ll wait.',
        time: '15.11.2026 14:38'
    },
    {
        id: 2,
        author: 'edd',
        isStaff: true,
        isMine: false,
        text: 'OK. I\'m here... Do you have any additional informations to this report?',
        time: '15.11.2026 14:43'
    }
]);

function bevels(msg: Message, i: number, total: number) {
    const first = i === 0;
    const last = i === total - 1;

    return [
        msg.isMine ? 'bevel-tl bevel-bl' : 'bevel-tr bevel-br',
        first && (msg.isMine ? 'bevel-tr' : 'bevel-tl'),
        last && (msg.isMine ? 'bevel-br' : 'bevel-bl')
    ].filter(Boolean).join(' ');
}
</script>

<div class="flex flex-col gap-3 w-[600px]" style="--bevel: 12px">
    <div>
        <h1 class="text-4xl font-semibold leading-none">CHAT</h1>
        <p class="text-[17px] leading-none text-gray-300">Here you can communicate with admin staff.</p>
    </div>

    <div class="w-4/5 h-1 bg-white/25 -skew-x-[45deg]"></div>

    <div class="bg-white/15 h-full bevel-top p-3 flex flex-col gap-2 overflow-y-auto">
        {#each messages as msg, index (msg.id)}
            <div 
                class="flex flex-col max-w-[80%] w-fit bg-black/65 px-3 py-1.5 chat-box {msg.isMine ? "self-end items-end" : "self-start items-start"}
                {bevels(msg, index, messages.length)}"
            >
                <div class="flex w-full items-center justify-between gap-4">
                    <div class="flex items-center gap-2 font-semibold">
                        {#if msg.isStaff}
                            <i class="hgi hgi-stroke hgi-rounded hgi-shield-user gradient-title"></i>
                        {/if}
                        <p class:gradient-title={msg.isStaff}>{msg.author}</p>
                    </div>
                    <p class="text-sm text-gray-300">{msg.time}</p>
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
        >
    </div>
</div>