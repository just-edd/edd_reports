import { derived, writable } from 'svelte/store';

export type Locale = Record<string, string>;

const locale = writable<Locale>({});

export const setLocale = (data: Locale) => locale.set(data);

// Fallback function for translating keys, so `undefined` never appears in the UI
export const t = derived(locale, ($locale) => (key: string) => $locale[key] ?? key);