import { Controller } from "@hotwired/stimulus";

export class Base<T = HTMLElement> extends Controller {
  // eslint-disable-next-line @typescript-eslint/ban-ts-comment
  // @ts-ignore
  get element(): T {
    return this.scope.element as unknown as T;
  }
}
