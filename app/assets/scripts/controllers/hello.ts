import { Controller } from "@hotwired/stimulus";

export class Hello extends Controller {
  static targets = ["name"];

  nameTarget: HTMLSpanElement;

  handleSayHello() {
    this.nameTarget.textContent = "John";
  }
}
