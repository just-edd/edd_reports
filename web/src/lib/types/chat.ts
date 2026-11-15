export interface Message {
    author: string;
    text: string;
    isStaff?: boolean;
    role?: string;
    isMine?: boolean;
    time: number; // '15.11.2026 14:35'
};