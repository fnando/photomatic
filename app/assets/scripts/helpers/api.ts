import { postCommentsUrl, likePostUrl } from "config/routes";
import { trackError } from "helpers/trackError";

const csrfToken = (): string =>
  document
    .querySelector<HTMLMetaElement>("meta[name=csrf-token]")
    .getAttribute("content");

// eslint-disable-next-line @typescript-eslint/no-explicit-any
export function post(path: string, params: any = null) {
  const body = params ? JSON.stringify(params) : null;

  return fetch(path, {
    method: "post",
    body,
    headers: {
      "Content-Type": "application/json",
      "X-CSRF-Token": csrfToken(),
    },
  });
}

// eslint-disable-next-line @typescript-eslint/no-explicit-any
export function del(path: string) {
  return fetch(path, {
    method: "delete",
    headers: {
      "Content-Type": "application/json",
      "X-CSRF-Token": csrfToken(),
    },
  });
}

export async function likePost(id: string): Promise<boolean> {
  try {
    const result = await post(likePostUrl(id));

    if (result.ok) {
      return true;
    } else {
      return false;
    }
  } catch (error) {
    trackError(error, { source: "likePost" });
    return false;
  }
}

export async function unlikePost(id: string): Promise<boolean> {
  try {
    const result = await del(likePostUrl(id));

    if (result.ok) {
      return true;
    } else {
      return false;
    }
  } catch (error) {
    trackError(error, { source: "unlikePost" });
    return false;
  }
}

export async function postComment({
  id,
  text,
}: {
  id: string;
  text: string;
}): Promise<string> {
  try {
    const result = await post(postCommentsUrl(id), { text });

    if (result.ok) {
      const html = await result.text();
      return html;
    } else {
      return "";
    }
  } catch (error) {
    trackError(error, { source: "postComment" });
    return "";
  }
}
