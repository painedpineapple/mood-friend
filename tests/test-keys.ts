import * as anchor from "@coral-xyz/anchor";

// use determinstic keys for easier testing on devnet
const seedStart = Buffer.from(
  `5e9981ac81c7389a53ec0eb594dc864db2e802d2a84f192b059d8f70fdc66f9d`,
  `hex`
).subarray(0, 31);

// create 1000 keys
export const keypairs = Array.from(Array(1000).keys()).map((key) =>
  anchor.web3.Keypair.fromSeed(Uint8Array.from([...seedStart, key]))
);
