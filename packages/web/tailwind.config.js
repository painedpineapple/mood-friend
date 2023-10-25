import sharedConfig from "../../tailwind.config";

export default {
  ...sharedConfig,
  content: ["./packages/**/*.{mjs,bs.js,js,res}"],
};
