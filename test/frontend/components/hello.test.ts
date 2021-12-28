import { Application } from "@hotwired/stimulus";
import { Hello } from "controllers/hello";

describe("Hello", () => {
  beforeEach(() => {
    document.body.innerHTML = `
      <div data-controller="hello">
        hello there, <span data-hello-target="name">stranger</span>!
        <button data-action="click->hello#handleSayHello">Say hello!</button>
      </div>
    `;

    const application = Application.start();
    application.register("hello", Hello);
  });

  it("says hello", () => {
    const button = document.querySelector("button") as HTMLButtonElement;
    const name = document.querySelector("span") as HTMLSpanElement;

    button.click();

    expect(name.textContent).toEqual("John");
  });
});
