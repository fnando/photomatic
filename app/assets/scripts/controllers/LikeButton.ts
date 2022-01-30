import { Controller } from "@hotwired/stimulus";

import { likePostUrl } from "config/routes";

export class LikeButton extends Controller {
  static targets = ["icon"];

  iconTarget: SVGElement;

  connect() {
    this.render();
  }

  async handleClick() {
    const button = this.element as HTMLButtonElement;
    const state = JSON.parse(button.dataset.liked);
    const newState = !state;

    button.dataset.liked = newState.toString();

    try {
      const method = newState ? "post" : "delete";
      const result = await fetch(likePostUrl(button.dataset.postId), {
        method,
      });
      console.log(await result.json());
    } catch (error) {
      console.log({ error });
    }
  }

  render() {}
}
