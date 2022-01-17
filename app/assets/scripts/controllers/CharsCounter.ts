import { Controller } from "@hotwired/stimulus";

import { subscribe } from "helpers/subscribe";

export class CharsCounter extends Controller {
  static targets = ["count", "input"];

  public subscriptions: (() => void)[] = [];
  public limit = 0;

  inputTarget: HTMLInputElement;
  countTarget: HTMLSpanElement;

  connect() {
    this.limit = parseInt(
      (this.element as HTMLElement).dataset.charsCounterLimit,
      10,
    );

    this.subscriptions.push(
      subscribe(this.inputTarget, "input", this.handleInput.bind(this)),
    );

    this.render();
  }

  disconnect() {
    this.subscriptions.forEach((unsubscribe) => unsubscribe());
  }

  handleInput() {
    this.render();
  }

  render() {
    const availableChars = this.limit - this.inputTarget.value.length;
    const availablePercentage = availableChars / this.limit;
    let state = "available";

    if (availablePercentage < 0.2) {
      state = "warning";
    }

    if (availableChars <= 0) {
      state = "error";
    }

    this.countTarget.textContent = String(availableChars);
    this.countTarget.dataset.charsCounterState = state;
  }
}
