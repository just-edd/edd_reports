import { cubicOut } from 'svelte/easing';
import type { TransitionConfig } from 'svelte/transition';

export function slideWidth(
  node: HTMLElement,
  { delay = 0, duration = 400, easing = cubicOut, gap = 40 } = {}
): TransitionConfig {
  const width = node.getBoundingClientRect().width;

  return {
    delay,
    duration,
    easing,
    css: (t, u) => `
      width: ${width * t}px;
      margin-left: ${gap * t}px;
      opacity: ${t};
      transform: translateX(${-u * 40}px);
      overflow: hidden;
      white-space: nowrap;
    `
  };
}