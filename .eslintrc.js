module.exports = {
  root: true,
  ignorePatterns: ["**/builds/**/*"],
  extends: ["@fnando/codestyle/javascript", "@fnando/codestyle/typescript"],
  rules: {
    "lines-between-class-members": "off",
    "prefer-destructuring": "off",
  },
};
