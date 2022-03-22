import { Base } from "controllers/Base";
import { subscribe } from "helpers/subscribe";

const closingClass = "menu-closing";

export class Menu extends Base {
  static targets = ["button", "menu"];

  public subscriptions: (() => void)[] = [];

  buttonTarget: HTMLButtonElement;
  menuTarget: HTMLDivElement;

  connect() {
    this.subscriptions.push(
      subscribe(window, "keyup", this.handleKeyUp.bind(this)),
      subscribe(
        this.menuTarget,
        "animationend",
        this.handleAnimation.bind(this),
      ),
    );
  }

  disconnect() {
    this.subscriptions.forEach((unsubscribe) => unsubscribe());
  }

  handleKeyUp(event: KeyboardEvent) {
    if (event.key === "Escape") {
      event.stopPropagation();
      event.preventDefault();

      this.menuTarget.classList.add(closingClass);
    }
  }

  handleClick() {
    if (this.menuTarget.hidden) {
      this.menuTarget.hidden = false;
      return;
    }

    this.menuTarget.classList.add(closingClass);
  }

  isMenuClosing() {
    return this.menuTarget.classList.contains(closingClass);
  }

  handleAnimation() {
    if (this.isMenuClosing()) {
      this.menuTarget.hidden = true;
      this.menuTarget.classList.remove(closingClass);
    }
  }
}
