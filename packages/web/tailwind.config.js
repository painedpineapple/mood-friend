import sharedConfig from "../../tailwind.shared.config";

// Remix automatically runs tailwind compiler per the `tailwind: true` boolean set as the default value in the `remix.config.js`
export default {
  ...sharedConfig,
  content: ["./packages/**/*.{mjs,bs.js,js,res}"],
};
