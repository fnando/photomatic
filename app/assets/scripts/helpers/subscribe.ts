export function subscribe(
  target: HTMLElement,
  type: string,
  handler: (event: unknown) => void,
) {
  const fn = (event: Event) => handler(event);

  target.addEventListener(type, fn, true);

  return () => target.removeEventListener(type, fn);
}
