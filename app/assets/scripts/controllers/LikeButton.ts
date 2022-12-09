import { Base } from "controllers/Base";
import { likePost, unlikePost } from "helpers/api";
import { trackError } from "helpers/trackError";
import * as analytics from "helpers/analytics";

export class LikeButton extends Base<HTMLButtonElement> {
  static targets = ["icon"];

  iconTarget: SVGElement;

  async handleClick() {
    const button = this.element;
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
}
