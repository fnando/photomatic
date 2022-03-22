import { transformKeys } from "helpers/transformKeys";

describe("transformKeys", () => {
  it("transform underscore keys to camelcase", () => {
    const actual = { user_id: 1234, items: [1, { display_name: "John" }] };
    const expected = { userId: 1234, items: [1, { displayName: "John" }] };

    expect(transformKeys(actual)).toEqual(expected);
  });
});
