/** @type {import('@remix-run/dev').AppConfig} */
module.exports = {
  serverModuleFormat: "cjs",
  appDirectory: "pages",
  // We handle this outside of remix
  tailwind: false,
  postcss: false,
  ignoredRouteFiles: [
    "**/.*",
    "**/*.res",
    "**/*.bs.js",
    "**/*.css",
    "**/*.test.{js,jsx,ts,tsx}",
  ],
  serverDependenciesToBundle: [/^rescript.*/],
};
