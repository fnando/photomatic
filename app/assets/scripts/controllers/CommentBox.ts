import { Controller } from "@hotwired/stimulus";
import { debug } from "helpers/debug";
import { subscribe } from "helpers/subscribe";

export class CommentBox extends Controller {
  static targets = ["button", "input", "list"];
  public subscriptions: (() => void)[] = [];

  buttonTarget: HTMLButtonElement;
  inputTarget: HTMLTextAreaElement;
  listTarget: HTMLDivElement;

  connect() {
    debug(this.buttonTarget, this.inputTarget, this.listTarget);

    this.subscriptions.push(
      subscribe(this.buttonTarget, "click", this.handleSubmit.bind(this)),
    );
  }

  disconnect(): void {
    this.subscriptions.forEach((unsubscribe) => unsubscribe());
  }

  handleSubmit() {}
}
