import { Application } from "@hotwired/stimulus";
import { CharsCounter } from "controllers/CharsCounter";

function find<T>(selector: string): T {
  const element = document.querySelector(selector);

  if (element) {
    return element as unknown as T;
  }

  throw new Error(`"${selector}" could not be found.`);
}

describe("CharsCounter", () => {
  beforeEach(() => {
    document.body.innerHTML = `
      <div data-controller="chars-counter" data-chars-counter-limit="10">
        <span data-chars-counter-target="count"></span>
        <textarea data-chars-counter-target="input"></textarea>
        <button data-chars-counter-target="button">Post</button>
      </div>
    `;

    const application = Application.start();
    application.register("chars-counter", CharsCounter);
  });

  it("disables button when no chars have been typed", () => {
    expect(find<HTMLButtonElement>("button").disabled).toBeTruthy();
  });

  it("enables button when at least one char has been typed", () => {
    const textarea = find<HTMLTextAreaElement>("textarea");

    textarea.value = "abc";
    textarea.dispatchEvent(new InputEvent("input"));

    expect(find<HTMLButtonElement>("button").disabled).toBeFalsy();
  });

  it("updates counter", () => {
    const textarea = find<HTMLTextAreaElement>("textarea");
    const counter = find<HTMLSpanElement>("span");
    const button = find<HTMLButtonElement>("button");

    textarea.value = "abc";
    textarea.dispatchEvent(new InputEvent("input"));
    expect(counter.textContent).toEqual("7");
    expect(counter.dataset.charsCounterState).toEqual("available");
    expect(button.disabled).toBeFalsy();

    textarea.value = "abcdefghi";
    textarea.dispatchEvent(new InputEvent("input"));
    expect(counter.textContent).toEqual("1");
    expect(counter.dataset.charsCounterState).toEqual("warning");
    expect(button.disabled).toBeFalsy();

    textarea.value = "abcdefghij";
    textarea.dispatchEvent(new InputEvent("input"));
    expect(counter.textContent).toEqual("0");
    expect(counter.dataset.charsCounterState).toEqual("error");
    expect(button.disabled).toBeTruthy();

    textarea.value = "abcdefghijk";
    textarea.dispatchEvent(new InputEvent("input"));
    expect(counter.textContent).toEqual("-1");
    expect(counter.dataset.charsCounterState).toEqual("error");
    expect(button.disabled).toBeTruthy();
  });
});
