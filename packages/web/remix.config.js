/** @type {import('@remix-run/dev').AppConfig} */
export default {
  appDirectory: "pages",
  ignoredRouteFiles: [
    ".*",
    "**/*.res",
    "**/*.bs.js",
    "**/*.css",
    "**/*.test.{js,jsx,ts,tsx}",
  ],
  postcss: true,
  dev: {
    manual: true,
  },
};
