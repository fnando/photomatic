import { Controller } from "@hotwired/stimulus";

import { subscribe } from "helpers/subscribe";

export class CharsCounter extends Controller {
  static targets = ["count", "input", "button"];

  public subscriptions: (() => void)[] = [];
  public limit = 0;

  inputTarget: HTMLInputElement;
  countTarget: HTMLSpanElement;
  buttonTarget: HTMLButtonElement;

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
    const charsCount = this.inputTarget.value.length;
    const availableChars = this.limit - charsCount;
    const availablePercentage = availableChars / this.limit;
    let state = "available";

    if (availablePercentage < 0.2) {
      state = "warning";
    }

    if (availableChars <= 0) {
      state = "error";
    }

    if (this.buttonTarget) {
      this.buttonTarget.disabled = state === "error" || charsCount === 0;
    }

    this.countTarget.textContent = String(availableChars);
    this.countTarget.dataset.charsCounterState = state;
  }
}
