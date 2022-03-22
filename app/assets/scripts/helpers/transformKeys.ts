import { camelCase } from "lodash";

export function transformKeys<T>(target: unknown): T {
  if (target instanceof Array) {
    return target.map((item) => transformKeys(item)) as unknown as T;
  }

  if (target instanceof Object) {
    return Object.keys(target).reduce(
      (buffer, key) =>
        Object.assign(buffer, { [camelCase(key)]: transformKeys(target[key]) }),
      {},
    ) as T;
  }

  return target as T;
}
