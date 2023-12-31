import * as web3 from "@solana/web3.js";
import * as anchor from "@coral-xyz/anchor";
import { PublicKey } from "@solana/web3.js";

export const getLifeMetricPda = (
  programId: PublicKey,
  userPubkey: PublicKey,
  baseAccount: PublicKey,
  offset: number
) =>
  web3.PublicKey.findProgramAddressSync(
    [
      Buffer.from("life_metric", "utf-8"),
      userPubkey.toBuffer(),
      baseAccount.toBuffer(),
      // baseAccountInfo.totalLifeMetrics
      new anchor.BN(offset).toArrayLike(
        Buffer,
        // little endian
        "le",
        // bytes
        4
      ),
    ],
    programId
  );
