import { debug } from "helpers/debug";

export function trackError(error: Error, context: unknown = {}) {
  debug("[error]", { error, context });
}
