import { Controller } from "@hotwired/stimulus";

import { likePost, unlikePost } from "helpers/api";

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
      const helper = newState ? likePost : unlikePost;
      // const result = await fetch(likePostUrl(button.dataset.postId), {
      //   method,
      // });

      const success = await helper(button.dataset.postId);

      console.log({ success });
    } catch (error) {
      console.log({ error });
    }
  }

  render() {}
}
