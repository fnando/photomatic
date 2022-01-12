module.exports = {
  content: ["./app/**/*.{erb,ts,sea}"],
  theme: {
    extend: {
      colors: {
        accent: "#0091ff",
        mute: "var(--mute-color)",
        "main-fg": "var(--text-color)",
        "main-bg": "var(--background-color)",
      },
    },
  },
  plugins: [
    require("@tailwindcss/aspect-ratio"),
    require("@tailwindcss/forms"),
    require("@tailwindcss/typography"),
  ],
};
