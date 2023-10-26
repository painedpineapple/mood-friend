// Need to have this in the same directory of bsconfig to work with the rescript plugin. It's here b/c we want a single bsconfig for the repo
import { defineConfig } from "vite";
import createReScriptPlugin from "@jihchi/vite-plugin-rescript";
import react from "@vitejs/plugin-react-swc";

// https://vitejs.dev/config/
export default defineConfig({
  root: "./packages/web",
  publicDir: "./packages/web/public",
  plugins: [
    react(),
    createReScriptPlugin({
      loader: {
        output: "./packages/web/",
        suffix: ".bs.js",
      },
    }),
  ],
});
