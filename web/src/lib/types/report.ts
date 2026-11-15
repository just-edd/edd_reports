import type { Message } from "./chat";

export interface ReportData {
    reportId: number;
    category: string;
    title: string;
    description?: string;
    link?: string;
    priority: string;
    createdAt: number; // ms timestamp
    createdBy: string;
    messages?: Message[];
}