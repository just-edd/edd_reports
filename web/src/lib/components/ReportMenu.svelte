<script lang="ts">
import { useNuiEvent } from "$lib/hooks/useNuiEvents";
import type { ReportData } from "$lib/types/report";
import { debugData } from "$lib/utils/debugData";

let reports: ReportData[] = $state([]);
let search = $state('');

const PAGE_SIZE = 6;
let page = $state(1);

debugData<ReportData[]>([
    {
        action: 'open_reports',
        data: [
            {
                reportId: 1,
                category: 'player',
                title: 'Help please. I got killed.',
                description: 'I was killed by random player.',
                link: 'https://medal.tv/adashbvcjfgh654',
                priority: 'medium',
                createdAt: 1794773775,
                createdBy: 'fivem:55315456',
                claimedBy: 'edd'
            },
            {
                reportId: 2,
                category: 'bug',
                title: 'Inventory does not open after respawn',
                description: 'After I respawn at the hospital, the inventory will not open until I relog. Happens every time.',
                link: 'https://medal.tv/clip/k29dnx81hs',
                priority: 'high',
                createdAt: 1794770120,
                createdBy: 'fivem:48201937',
                closed: true,
                claimedBy: 'johhn'
            },
            {
                reportId: 3,
                category: 'question',
                title: 'How do I apply for the police department?',
                description: 'I would like to join the LSPD, but I cannot find the application form anywhere. Where can I apply?',
                link: '',
                priority: 'low',
                createdAt: 1794765432,
                createdBy: 'fivem:61774208'
            },
            {
                reportId: 4,
                category: 'player',
                title: 'RDM and VDM near Legion Square',
                description: 'A player in a red Sultan ran over several people and then shot me without any RP reason.',
                link: 'https://streamable.com/x7q3lp',
                priority: 'urgent',
                createdAt: 1794758990,
                createdBy: 'fivem:33918765',
                closed: true,
                claimedBy: 'edd'
            },
            {
                reportId: 5,
                category: 'bug',
                title: 'Vehicle disappears when I leave the garage',
                description: 'I took my car out of the garage and it vanished after a few seconds. I lost the vehicle and the keys.',
                link: 'https://medal.tv/clip/p4mz90qwe1',
                priority: 'urgent',
                createdAt: 1794751204,
                createdBy: 'fivem:72045519'
            },
            {
                reportId: 6,
                category: 'question',
                title: 'Can I change my character name?',
                description: 'I made a typo in my character name. Is it possible to change it, and how much does it cost?',
                link: '',
                priority: 'medium',
                createdAt: 1794744861,
                createdBy: 'fivem:19560342',
                claimedBy: 'johhn'
            },
            {
                reportId: 7,
                category: 'player',
                title: 'Player is using aimbot',
                description: 'A player in the city hits every headshot from a huge distance and never misses. Looks like cheating.',
                link: 'https://medal.tv/clip/h8f2kq91zd',
                priority: 'high',
                createdAt: 1794738410,
                createdBy: 'fivem:90127654',
                claimedBy: 'edd'
            },
            {
                reportId: 8,
                category: 'bug',
                title: 'Phone shows black screen',
                description: 'When I open the phone, I only see a black screen. Closing and opening it again does not help.',
                link: 'https://streamable.com/m3v7te',
                priority: 'medium',
                createdAt: 1794731902,
                createdBy: 'fivem:27483019',
                closed: true,
                claimedBy: 'johhn'
            },
            {
                reportId: 9,
                category: 'question',
                title: 'Where can I buy a house?',
                description: 'I have enough money for a house, but I do not know which job or NPC handles real estate.',
                link: '',
                priority: 'low',
                createdAt: 1794725577,
                createdBy: 'fivem:58830247'
            },
            {
                reportId: 10,
                category: 'player',
                title: 'Admin abuse by staff member',
                description: 'A staff member teleported me and took my weapons without giving any reason in the chat.',
                link: 'https://medal.tv/clip/t6r1xw40np',
                priority: 'urgent',
                createdAt: 1794719033,
                createdBy: 'fivem:41905872',
                claimedBy: 'edd'
            },
            {
                reportId: 11,
                category: 'bug',
                title: 'Money not added after job payout',
                description: 'I finished the delivery job but my payout was never added to my bank account.',
                link: 'https://medal.tv/clip/c9y5ub23lm',
                priority: 'high',
                createdAt: 1794712648,
                createdBy: 'fivem:83619405',
                closed: true,
                claimedBy: 'edd'
            },
            {
                reportId: 12,
                category: 'question',
                title: 'How do I report a stuck vehicle?',
                description: 'My car is stuck under the map near the docks. Is there a command to get it back?',
                link: '',
                priority: 'medium',
                createdAt: 1794706215,
                createdBy: 'fivem:36274891'
            }
        ]
    }
]);

useNuiEvent<ReportData[]>('open_reports', (data) => {
    reports = data;
});

let badges: { icon: string, label: string, description: string, value: number }[] = $derived([
    { icon: 'hgi-analytics-01', label: 'Pending reports', description: 'All active reports.', value: reports.filter((rep) => !rep.closed).length },
    { icon: 'hgi-book-03', label: 'Closed reports', description: 'All closed reports.', value: reports.filter((rep) => rep.closed).length },
    { icon: 'hgi-user-question-01', label: 'Unclaimed reports', description: 'Waiting for an admin.', value: reports.filter((rep) => !rep.closed && !rep.claimedBy).length },
    { icon: 'hgi-file-01', label: 'Total reports', description: 'All reports ever made.', value: reports.length }
]);

let filteredReports = $derived.by(() => {
    const query = search.trim().toLowerCase().replace('#', '');
    if (!query) return reports;

    return reports.filter((rep) =>
        [
            String(rep.reportId),
            rep.title,
            rep.description,
            rep.category,
            rep.priority,
            rep.claimedBy ?? '',
            rep.createdBy
        ].some((field) => field!.toLowerCase().includes(query))
    );
});

let totalPages = $derived(Math.max(1, Math.ceil(filteredReports.length / PAGE_SIZE)));
let paginatedReports = $derived(filteredReports.slice((page - 1) * PAGE_SIZE, page * PAGE_SIZE));

// If searching return to page 1
$effect(() => {
    search;
    page = 1;
});

// If list gets updated, update pages
$effect(() => {
    if (page > totalPages) page = totalPages;
});

const priorityStyles: Record<ReportData['priority'], string> = {
    low: 'bg-gray-500/60 text-gray-100',
    medium: 'bg-yellow-500/60 text-yellow-100',
    high: 'bg-orange-500/60 text-orange-100',
    urgent: 'bg-red-600/70 text-red-100'
};

const categoryIcons: any = {
    player: 'hgi-user-warning-01',
    bug: 'hgi-bug-02',
    question: 'hgi-help-circle'
};

function timeAgo(timestamp: number) {
    const diff = Math.floor(Date.now() / 1000) - timestamp;
    if (diff < 60) return 'just now';
    if (diff < 3600) return `${Math.floor(diff / 60)}m ago`;
    if (diff < 86400) return `${Math.floor(diff / 3600)}h ago`;
    return `${Math.floor(diff / 86400)}d ago`;
}
</script>

<div class="flex flex-col justify-center w-[750px] gap-3">
    <div>
        <h1 class="text-4xl font-semibold leading-none">
            REPORT SYSTEM <span
                class="gradient-title drop-shadow-[0_0_10px_#8acf22]">MENU</span
            >
        </h1>
        <p class="text-[17px] text-gray-300 leading-none">
            Check all reports whether it's pending or closed.
        </p>
    </div>

    <div class="w-4/5 h-1 bg-white/25 -skew-x-[45deg]"></div>

    <div class="bg-white/15 w-full bevel p-2 flex flex-col gap-1.5">
        <div class="grid grid-cols-2 gap-2">
            {#each badges as badge}
                <div
                    class="flex items-center justify-between bg-black/50 py-1 px-4 bevel"
                >
                    <div>
                        <div class="flex items-center gap-2">
                            <i
                                class="hgi hgi-stroke hgi-rounded {badge.icon} gradient-title text-2xl"
                            ></i>
                            <p>{badge.label.toUpperCase()}</p>
                        </div>

                        <p class="text-gray-300">{badge.description}</p>
                    </div>

                    <p
                        class="bg-gray-400/75 bevel font-medium flex items-center justify-center w-8"
                        style="--bevel: 6px"
                    >
                        {badge.value}
                    </p>
                </div>
            {/each}
        </div>

        <div>
            <div
                class="bg-black/80 py-1 px-3 bevel flex items-center gap-2"
                style="--bevel: 8px"
            >
                <i
                    class="hgi hgi-stroke hgi-rounded hgi-search-02 gradient-title"
                ></i>
                <input
                    type="text"
                    bind:value={search}
                    class="w-full bg-transparent focus:outline-none placeholder:text-gray-300"
                    placeholder="Search by title, ID, admin..."
                />
            </div>
        </div>

        <div class="max-h-[400px] overflow-y-auto">
            <table
                class="w-full text-left text-sm border-separate border-spacing-y-1"
            >
                <thead class="bg-black/50 bevel" style="--bevel: 8px">
                    <tr>
                        <th class="px-3 py-2">ID</th>
                        <th class="px-3 py-2">Category</th>
                        <th class="px-3 py-2">Title</th>
                        <th class="px-3 py-2">Priority</th>
                        <th class="px-3 py-2">Status</th>
                        <th class="px-3 py-2">Claimed by</th>
                        <th class="px-3 py-2">Created</th>
                    </tr>
                </thead>
                <tbody>
                    {#each paginatedReports as report (report.reportId)}
                        <tr
                            class="bg-black/50 hover:bg-black/70 cursor-pointer transition-colors bevel"
                            style="--bevel: 8px"
                        >
                            <td class="px-3 py-2 text-gray-300"
                                >#{report.reportId}</td
                            >
                            <td class="px-3 py-2">
                                <div class="flex items-center gap-2 capitalize">
                                    <i
                                        class="hgi hgi-stroke hgi-rounded {categoryIcons[
                                            report.category
                                        ]} gradient-title text-lg"
                                    ></i>
                                    {report.category}
                                </div>
                            </td>
                            <td class="px-3 py-2 max-w-[200px] truncate"
                                >{report.title}</td
                            >
                            <td class="px-3 py-2">
                                <span
                                    class="px-2 py-0.5 bevel uppercase text-xs {priorityStyles[
                                        report.priority
                                    ]}"
                                    style="--bevel: 5px"
                                >
                                    {report.priority}
                                </span>
                            </td>
                            <td class="px-3 py-2">
                                {#if report.closed}
                                    <span class="text-gray-300">Closed</span>
                                {:else}
                                    <span class="gradient-title">Pending</span>
                                {/if}
                            </td>
                            <td class="px-3 py-2 text-gray-300"
                                >{report.claimedBy ?? "-"}</td
                            >
                            <td class="px-3 py-2 text-gray-300"
                                >{timeAgo(report.createdAt)}</td
                            >
                        </tr>
                    {:else}
                        <tr class="bg-black/50 bevel" style="--bevel: 8px">
                            <td
                                colspan="7"
                                class="px-3 py-6 text-center text-gray-300"
                                >No reports found.</td
                            >
                        </tr>
                    {/each}
                </tbody>
            </table>
        </div>

        {#if filteredReports.length > PAGE_SIZE}
            <div class="flex items-center gap-1 self-end">
                <!-- svelte-ignore a11y_consider_explicit_label -->
                <button
                    class="bg-gradient-to-br from-[#8acf22a0] to-[#caf388a0] w-8 flex items-center justify-center py-1 bevel disabled:opacity-50"
                    style="--bevel: 6px"
                    disabled={page === 1}
                    onclick={() => page--}
                >
                    <i
                        class="hgi hgi-stroke hgi-rounded hgi-arrow-move-down-left"
                    ></i>
                </button>

                <!-- svelte-ignore a11y_consider_explicit_label -->
                <button
                    class="bg-gradient-to-br from-[#8acf22a0] to-[#caf388a0] w-8 flex items-center justify-center py-1 bevel disabled:opacity-50"
                    style="--bevel: 6px"
                    disabled={page === totalPages}
                    onclick={() => page++}
                >
                    <i
                        class="hgi hgi-stroke hgi-rounded hgi-arrow-move-down-right"
                    ></i>
                </button>
            </div>
        {/if}
    </div>
</div>
