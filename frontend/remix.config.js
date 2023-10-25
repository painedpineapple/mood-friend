/** @type {import('@remix-run/dev').AppConfig} */
export default {
  appDirectory: "pages",
  // We handle this outside of remix
  tailwind: false,
  postcss: false,
  ignoredRouteFiles: [
    ".*",
    "**/*.res",
    "**/*.bs.js",
    "**/*.css",
    "**/*.test.{js,jsx,ts,tsx}",
  ],
};
