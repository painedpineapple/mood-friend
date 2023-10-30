open BindingHelpers

type cluster = [#devnet | #testnet | #"mainnet-beta"]
type finality = [#confirmed | #finalized | #processed]

type blockhash = string

type commitment = [
  | #processed
  | #confirmed
  | #finalized
  | #recent
  | #single
  | #singleGossip
  | #root
  | #max
]

module PublicKey = {
  type t

  // number | string | Uint8Array | Array<number> | PublicKeyData;
  @unboxed
  type rec publicKeyInitData = PublicKeyInitData('a): publicKeyInitData

  @module("@solana/web3.js") @new
  external make: publicKeyInitData => t = "PublicKey"

  @module("@solana/web3.js") @scope("PublicKey")
  external unique: unit => t = "unique"

  @module("@solana/web3.js") @scope("PublicKey")
  external default: unit => t = "default"

  @module("@solana/web3.js") @scope("PublicKey")
  external equals: (t, t) => bool = "equals"

  @send
  external toBase58: t => string = "toBase58"

  @send
  external toJSON: t => string = "toJSON"

  @send
  external toBytes: t => array<int> = "toBytes"

  @send
  external toBuffer: t => Buffer.t = "toBuffer"

  @send
  external toString: t => string = "toString"

  @module("@solana/web3.js") @scope("PublicKey")
  external createWithSeed: (t, string, t) => Js.Promise.t<t> = "createWithSeed"

  @module("@solana/web3.js") @scope("PublicKey")
  external createProgramAddressSync: (array<Buffer.t>, t) => t = "createProgramAddressSync"

  @module("@solana/web3.js") @scope("PublicKey")
  external createProgramAddress: (array<Buffer.t>, t) => Js.Promise.t<t> = "createProgramAddress"

  @module("@solana/web3.js") @scope("PublicKey")
  external findProgramAddressSync: (array<Buffer.t>, t) => (t, int) = "findProgramAddressSync"

  @module("@solana/web3.js") @scope("PublicKey")
  external findProgramAddress: (array<Buffer.t>, t) => Js.Promise.t<(t, int)> = "findProgramAddress"

  @module("@solana/web3.js") @scope("PublicKey")
  external isOnCurve: unit => bool = "isOnCurve"
}

module Connection = {
  type blockhashWithExpiryBlockHeight = {
    blockhash: blockhash,
    lastValidBlockHeight: number,
  }

  type config = {commitment: finality}

  type t = {
    latestBlockhash: Js.Null.t<blockhashWithExpiryBlockHeight>,
    lastFetch: number,
    simulatedSignatures: array<string>,
    transactionSignatures: array<string>,
  }

  @module("@solana/web3.js") @new
  external make: (string, config) => t = "Connection"

  @send
  external getBalance: (t, PublicKey.t, ~config: config=?, unit) => Js.Promise.t<int> = "getBalance"
}

@module("@solana/web3.js")
external clusterApiUrl: (~cluster: cluster, ~tls: bool=?, unit) => string = "clusterApiUrl"

type accountMeta = {
  pubkey: PublicKey.t,
  isSigner: bool,
  isWritable: bool,
}

type transactionStatus =
  // Order is important. Expect these to be compiled as numbers starting at 0
  | BlockheightExceeded
  | Processed
  | TimedOut
  | NonceInvalid

type transactionSignature = string

type supportedTransactionVersions = option<
  [
    | #legacy
    | #0
  ],
>

type messageHeader = {
  /**
     * The number of signatures required for this message to be considered valid. The
     * signatures must match the first `numRequiredSignatures` of `accountKeys`.
     */
  numRequiredSignatures: int,
  /** The last `numReadonlySignedAccounts` of the signed keys are read-only accounts */
  numReadonlySignedAccounts: int,
  /** The last `numReadonlySignedAccounts` of the unsigned keys are read-only accounts */
  numReadonlyUnsignedAccounts: int,
}

type compiledInstruction = {
  /** Index into the transaction keys array indicating the program account that executes this instruction */
  programIdIndex: int,
  /** Ordered indices into the transaction keys array indicating which accounts to pass to the program */
  accounts: array<int>,
  /** The program input data encoded as base 58 */
  data: string,
}

type messageCompiledInstruction = {
  /** Index into the transaction keys array indicating the program account that executes this instruction */
  programIdIndex: int,
  /** Ordered indices into the transaction keys array indicating which accounts to pass to the program */
  accountKeyIndexes: array<int>,
  /** The program input data */
  data: RescriptCore.Uint32Array.t,
}

type messageAddressTableLookup = {
  accountKey: PublicKey.t,
  writableIndexes: array<int>,
  readonlyIndexes: array<int>,
}

type loadedAddresses = {
  writable: array<PublicKey.t>,
  readonly: array<PublicKey.t>,
}

type accountKeysFromLookups = loadedAddresses

type transactionInstruction = {
  /**
     * Public keys to include in this transaction
     * Boolean represents whether this pubkey needs to sign the transaction
     */
  keys: array<accountMeta>,
  /**
     * Program Id to execute
     */
  programId: PublicKey.t,
  /**
     * Program input
     */
  data: Buffer.t,
}

type messageAccountKeys = {
  staticAcountKeys: array<PublicKey.t>,
  addressKeysFromLookups: option<accountKeysFromLookups>,
  keySegments: array<array<PublicKey.t>>,
  get: int => PublicKey.t,
  length: int,
  compileInstructions: array<transactionInstruction> => array<messageCompiledInstruction>,
}

module Message = {
  type t

  type args = {
    /** The message header, identifying signed and read-only `accountKeys` */
    header: messageHeader,
    /** All the account keys used by this transaction */
    accountKeys: array<PublicKey.t>,
    /** The hash of a recent ledger block */
    recentBlockhash: blockhash,
    /** Instructions that will be executed in sequence and committed in one atomic transaction if all succeed. */
    instructions: array<compiledInstruction>,
  }

  @new @module("@solana/web3.js")
  external make: args => t = "Message"

  @val
  external version: string = "version"

  @val
  external header: messageHeader = "header"

  @val
  external accountKeys: PublicKey.t = "accountKeys"

  @val
  external recentBlockhash: blockhash = "recentBlockhash"

  @val
  external instructions: array<compiledInstruction> = "instructions"

  @val
  external staticAcountKeys: array<PublicKey.t> = "staticAcountKeys"

  @val
  external compiledInstructions: array<messageCompiledInstruction> = "compiledInstructions"

  @val
  external addressTableLookups: array<messageAddressTableLookup> = "addressTableLookups"

  @send
  external getAccountKeys: unit => messageAccountKeys = "getAccountKeys"

  type compileArgs = {
    payerKey: PublicKey.t,
    instructions: array<transactionInstruction>,
    recentBlockhash: blockhash,
  }

  @send
  external compile: compileArgs => t = "compile"

  @send
  external isAccountSigner: int => bool = "isAccountSigner"

  @send
  external isAccountWritable: int => bool = "isAccountWritable"

  @send
  external isProgramId: int => bool = "isProgramId"

  @send
  external programIds: unit => array<PublicKey.t> = "programIds"

  @send
  external nonProgramIds: unit => array<PublicKey.t> = "nonProgramIds"

  @send external serialize: unit => Buffer.t = "serialize"

  @send
  external fromBuffer: Buffer.t => t = "from"

  @send
  external fromUnit8Array: RescriptCore.Uint8Array.t => t = "from"

  @send
  external fromArrayInt: array<int> => t = "from"
}

module AddressLookupTableAccount = {
  type t

  type state = {
    deactivationSlot: Bigint.t,
    lastExtendedSlot: int,
    lastExtendedSlotStartIndex: int,
    authority: option<PublicKey.t>,
    addresses: array<PublicKey.t>,
  }
  type accountArgs = {
    key: PublicKey.t,
    state: state,
  }

  @val
  external key: PublicKey.t = "key"

  @val
  external state: state = "state"

  @new @module("@solana/web3.js")
  external make: accountArgs => t = "AddressLookupTableAccount"

  @send
  external isActive: unit => bool = "isActive"

  @send
  external deserialize: RescriptCore.Uint8Array.t => state = "deserialize"
}

module MessageV0 = {
  type t

  @val
  external version: int = "version"

  @val
  external header: messageHeader = "header"

  @val
  external staticAccountKeys: PublicKey.t = "accountKeys"

  @val
  external recentBlockhash: blockhash = "recentBlockhash"

  @val
  external compiledInstructions: array<messageCompiledInstruction> = "compiledInstructions"

  @val
  external addressTableLookups: array<messageAddressTableLookup> = "addressTableLookups"

  @val
  external numAccountKeysFromLookups: int = "numAccountKeysFromLookups"

  @send
  external resolveAddressTableLookups: unit => accountKeysFromLookups = "resolveAddressTableLookups"

  @send
  external getAccountKeys: unit => messageAccountKeys = "getAccountKeys"

  type compileArgs = {
    payerKey: PublicKey.t,
    instructions: array<transactionInstruction>,
    recentBlockhash: blockhash,
    addressLookupTableAccounts: option<array<AddressLookupTableAccount.t>>,
  }

  @send
  external compile: compileArgs => t = "compile"

  @send
  external isAccountSigner: int => bool = "isAccountSigner"

  @send
  external isAccountWritable: int => bool = "isAccountWritable"

  @send external serialize: unit => Buffer.t = "serialize"

  @send external deserialize: RescriptCore.Uint8Array.t => t = "deserialize"

  type args = {
    /** The message header, identifying signed and read-only `accountKeys` */
    header: messageHeader,
    /** The static account keys used by this transaction */
    staticAccountKeys: array<PublicKey.t>,
    /** The hash of a recent ledger block */
    recentBlockhash: blockhash,
    /** Instructions that will be executed in sequence and committed in one atomic transaction if all succeed. */
    compiledInstructions: array<messageCompiledInstruction>,
    /** Instructions that will be executed in sequence and committed in one atomic transaction if all succeed. */
    addressTableLookups: array<messageAddressTableLookup>,
  }

  type serializeInstructionsT

  @val
  external serializeInstructions: serializeInstructionsT = "serializeInstructions"

  type serializeAddressTableLookupsT

  @val
  external serializeAddressTableLookups: serializeAddressTableLookupsT =
    "serializeAddressTableLookups"

  @new @module("@solana/web3.js")
  external make: args => t = "MessageV0"
}

@tag("version")
type versionedMessage =
  | @as(0) MessageV0(MessageV0.t)
  | @as("legacy") Message(Message.t)
