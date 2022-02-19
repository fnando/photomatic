import { Controller } from "@hotwired/stimulus";

import { likePost, unlikePost } from "helpers/api";
import { trackError } from "helpers/trackError";
import * as analytics from "helpers/analytics";

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
    const { postId } = button.dataset;

    const like = async () => {
      await likePost(postId);
      analytics.like(postId);
    };

    const unlike = async () => {
      await unlikePost(postId);
      analytics.unlike(postId);
    };

    button.dataset.liked = newState.toString();

    try {
      await (newState ? like() : unlike());
    } catch (error) {
      trackError(error);
    }
  }

  render() {}
}
