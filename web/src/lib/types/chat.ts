export type Message = {
    id: number;
    author: string;
    isStaff: boolean;
    isMine: boolean;
    text: string;
    time: string;
};