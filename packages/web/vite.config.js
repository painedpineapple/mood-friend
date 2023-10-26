import { defineConfig } from "vite";
import createReScriptPlugin from "@jihchi/vite-plugin-rescript";
import react from "@vitejs/plugin-react-swc";

// https://vitejs.dev/config/
export default defineConfig({
  plugins: [
    react(),
    createReScriptPlugin({
      loader: {
        output: "./",
        suffix: ".bs.js",
      },
    }),
  ],
});
