interface Listenable {
  addEventListener(
    type: string,
    callback: (event: Event) => void | boolean,
    capture: boolean | AddEventListenerOptions,
  ): void;

  removeEventListener(type: string, callback: (event: Event) => void): void;
}

export function subscribe(
  target: Listenable,
  type: string,
  handler: (event: unknown) => void,
) {
  const fn = (event: Event) => handler(event);

  target.addEventListener(type, fn, true);

  return () => target.removeEventListener(type, fn);
}
