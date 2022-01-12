import * as template from "helpers/templates";
import { i18n } from "config/i18n";

export const helpers = {
  i18n({ path, ...options }: { path: string }): string {
    return i18n.t(path, options);
  },

  fileSizeFormat(size: number): string {
    return i18n.numberToHumanSize(size);
  },
};

export function render(
  name: string,
  context: { [key: string]: unknown },
): string {
  return template[name]({ ...helpers, ...context });
}
