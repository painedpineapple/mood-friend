import * as anchor from "@coral-xyz/anchor";
import { Program } from "@coral-xyz/anchor";
import NodeWallet from "@coral-xyz/anchor/dist/cjs/nodewallet";
import * as web3 from "@solana/web3.js";
import { expect } from "chai";
import { LifeMetric } from "../target/types/life_metric";
import { TEST_PASSPHRASE, decryptData, encryptData } from "./test-utils";
import { getLifeMetricPda } from "./pda-helpers";

describe("life-metric", () => {
  // Configure the client to use the local cluster.
  const provider = anchor.AnchorProvider.env();
  anchor.setProvider(provider);

  const program = anchor.workspace.LifeMetric as Program<LifeMetric>;
  const programId = new web3.PublicKey(program.programId);

  const userKeypair = (provider.wallet as NodeWallet).payer;

  it("Is initialized!", async () => {
    const [baseAccount, _bump] = web3.PublicKey.findProgramAddressSync(
      [Buffer.from("life_metric", "utf-8"), userKeypair.publicKey.toBuffer()],
      new web3.PublicKey(program.programId)
    );

    const baseAccountDataBefore = await anchor
      .getProvider()
      .connection.getParsedAccountInfo(baseAccount);

    // Add your test here.
    const tx = await program.methods
      .initialize()
      .accounts({
        baseAccount,
        user: userKeypair.publicKey,
        systemProgram: anchor.web3.SystemProgram.programId,
      })
      .rpc();

    const baseAccountDataAfter = await anchor
      .getProvider()
      .connection.getParsedAccountInfo(baseAccount);

    expect(baseAccountDataBefore.value).to.equal(null);

    expect(baseAccountDataAfter.value.lamports).to.equal(1057920);
  });

  it("creates life metric", async () => {
    const [baseAccount, _bump] = web3.PublicKey.findProgramAddressSync(
      [Buffer.from("life_metric", "utf-8"), userKeypair.publicKey.toBuffer()],
      new web3.PublicKey(program.programId)
    );

    const baseAccountInfoBefore =
      program.account.baseAccount.coder.accounts.decode(
        "BaseAccount",
        (await provider.connection.getAccountInfo(baseAccount)).data
      );

    const [lifeMetric, __bump] = getLifeMetricPda(
      programId,
      userKeypair.publicKey,
      baseAccount,
      baseAccountInfoBefore.totalLifeMetrics
    );

    const data = JSON.stringify({
      date: new anchor.BN(Date.now()),
      lowMood: "Sad",
      highMood: "HypoManic",
    });

    const { ciphertext, salt } = encryptData(data, TEST_PASSPHRASE);

    await program.methods
      .createLifeMetric(salt, ciphertext)
      .accounts({
        lifeMetric: lifeMetric,
        baseAccount,
        user: userKeypair.publicKey,
        systemProgram: anchor.web3.SystemProgram.programId,
      })
      .rpc();

    const baseAccountInfoAfter =
      program.account.baseAccount.coder.accounts.decode(
        "BaseAccount",
        (await provider.connection.getAccountInfo(baseAccount)).data
      );

    expect(baseAccountInfoAfter.totalLifeMetrics).to.equal(1);

    // TODO: why does this second life metric violate a seed constraint
    // await new Promise((resolve) => setTimeout(resolve, 10000));
    await program.methods
      .createLifeMetric(salt, ciphertext)
      .accounts({
        lifeMetric: lifeMetric,
        baseAccount,
        user: userKeypair.publicKey,
        systemProgram: anchor.web3.SystemProgram.programId,
      })
      .rpc();

    const userLifeMetricPdas = Array.from(
      { length: baseAccountInfoAfter.totalLifeMetrics },
      () => undefined
    ).map(
      (_, index) =>
        getLifeMetricPda(
          programId,
          userKeypair.publicKey,
          baseAccount,
          index
        )[0]
    );

    const lifeMetrics = await program.account.lifeMetric.fetchMultiple(
      userLifeMetricPdas
    );

    const decodedData = decryptData(
      lifeMetrics[0].ciphertext,
      lifeMetrics[0].salt,
      TEST_PASSPHRASE
    );

    expect(decodedData).to.equal(data);
  });
});
