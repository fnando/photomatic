import { i18n } from "config/i18n";
import { Base } from "controllers/Base";
import { postComment } from "helpers/api";
import { debug } from "helpers/debug";
import { subscribe } from "helpers/subscribe";

export class CommentBox extends Base {
  static targets = ["button", "input", "list"];
  public subscriptions: (() => void)[] = [];

  buttonTarget: HTMLButtonElement;
  inputTarget: HTMLTextAreaElement;
  listTarget: HTMLDivElement;

  connect() {
    this.subscriptions.push(
      subscribe(this.buttonTarget, "click", this.handleSubmit.bind(this)),
      subscribe(this.inputTarget, "keypress", this.handleKeypress.bind(this)),
    );
  }

  disconnect(): void {
    this.subscriptions.forEach((unsubscribe) => unsubscribe());
  }

  handleKeypress(event: KeyboardEvent) {
    if (event.metaKey && event.key === "Enter") {
      this.buttonTarget.dispatchEvent(new MouseEvent("click"));
    }
  }

  async handleSubmit() {
    const text = this.inputTarget.value;
    const id = this.element.dataset.postId;

    this.buttonTarget.textContent = i18n.t("js.comment_box.posting");
    this.inputTarget.disabled = true;
    this.buttonTarget.disabled = true;

    debug("[CommentBox]", { id });

    try {
      const html = await postComment({ id, text });

      if (html) {
        const node = document.createElement("div");
        node.innerHTML = html;
        const commentHtml = node.firstElementChild;
        this.listTarget.appendChild(commentHtml);
        this.inputTarget.value = "";

        location.href = `#${commentHtml.id}`;
      } else {
        // TODO: show message to users when posting comment fails.
      }
    } catch (error) {}

    this.buttonTarget.textContent = i18n.t("js.comment_box.post");
    this.inputTarget.disabled = false;
    this.buttonTarget.disabled = false;
  }
}
