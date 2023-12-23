import * as web3 from "@solana/web3.js";
import fs from "fs";

export const loadKeypair = (name: string) => {
  const file = fs.readFileSync(`${import.meta.dir}/../keys/${name}.json`, {
    encoding: "utf-8",
  });

  return web3.Keypair.fromSecretKey(Buffer.from(JSON.parse(file)));
};
