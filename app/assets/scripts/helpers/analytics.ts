import { debug } from "helpers/debug";

const user =
  document
    .querySelector<HTMLMetaElement>("meta[name=user-id]")
    ?.getAttribute("content") ?? "";

export function like(post: string) {
  debug("[analytics]", "user likes photo", { user, post });
}

export function unlike(post: string) {
  debug("[analytics]", "user unlikes photo", { user, post });
}
