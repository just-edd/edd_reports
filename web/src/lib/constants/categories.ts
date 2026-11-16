interface Category {
    label: string;
    icon: string;
    id: string;
};

interface Priority {
    label: string;
    id: string;
    color: string;
};

export const CATEGORIES: Category[] = [
    { label: 'Player', icon: 'hgi-complaint', id: 'player' },
    { label: 'Bug', icon: 'hgi-bug-02', id: 'bug' },
    { label: 'Question', icon: 'hgi-question', id: 'question' }
];

export const PRIORITIES: Priority[] = [
    { label: 'Low', color: '#65a30d', id: 'low' },
    { label: 'Medium', color: '#f59e0b', id: 'medium' },
    { label: 'High', color: '#dc2626', id: 'high' }
];