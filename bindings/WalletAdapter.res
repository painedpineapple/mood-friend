open Web3

type walletName = string

type readyState = [
  | #Installed // User-installable wallets can typically be detected by scanning for an API that they've injected into the global context. If such an API is present, we consider the wallet to have been installed.
  | #NotDetected
  | #Loadable // Loadable wallets are always available to you. Since you can load them at any time, it's meaningless to say that they have been detected.
  | #Unsupported
] // If a wallet is not supported on a given platform (eg. server-rendering, or mobile) then it will stay in the `Unsupported` state.

type adapter = {
  name: walletName,
  url: string,
  icon: string,
  connecting: bool,
  connected: bool,
  supportedTransactionVersions: option<supportedTransactionVersions>,
  publicKey: Js.Nullable.t<PublicKey.t>,
}

type wallet = {
  adapter: adapter,
  readyState: readyState,
}

type walletReadyState = [
  | #Installed
  | #NotDetected
  | #Loadable
  | #Unsupported
]

module SignTransaction = {}

type signTransaction
type signAllTransactions
type signMessage
type signIn = unit => unit

module SendTransaction = {
  @deriving(abstract)
  type options = {
    /** disable transaction verification step */
    @optional
    skipPreflight: bool,
    /** preflight commitment level */
    @optional
    preflightCommitment: commitment,
    /** Maximum number of times for the RPC node to retry sending the transaction to the leader. */
    @optional
    maxRetries: int,
    /** The minimum slot that the request can be evaluated at */
    @optional
    minContextSlot: int,
  }

  type fn = (
    ~versions: supportedTransactionVersions,
    ~connection: Connection.t,
    ~options: options,
  ) => Js.Promise.t<transactionSignature>
}

module Connection = {
  type t
}

module React_ = {
  type adapterProps = {
    sendTransaction: SendTransaction.fn,
    name: walletName,
    url: string,
    icon: string,
    readyState: readyState,
    connecting: bool,
    connected: bool,
    supportedTransactionVersions: option<supportedTransactionVersions>,
    autoConnect: unit => Js.Promise.t<unit>,
    connect: unit => Js.Promise.t<unit>,
    disconnect: unit => Js.Promise.t<unit>,
    publicKey: Js.Nullable.t<PublicKey.t>,
  }

  type contextState = {
    autoConnect: bool,
    wallets: array<wallet>,
    wallet: option<wallet>,
    publicKey: Js.Nullable.t<PublicKey.t>,
    connecting: bool,
    connected: bool,
    disconnecting: bool,
    select: option<walletName> => unit,
    connect: unit => Js.Promise.t<unit>,
    disconnect: unit => Js.Promise.t<unit>,
    sendTransaction: SendTransaction.fn,
    signTransaction: option<signTransaction>,
    signAllTransactions: signAllTransactions,
    signMessage: option<signMessage>,
    signIn: option<signIn>,
  }

  module ConnectionProvider = {
    @module("@solana/wallet-adapter-react") @react.component
    external make: (~endpoint: string, ~children: React.element) => React.element =
      "ConnectionProvider"
  }

  module WalletProvider = {
    type error

    type errorName = [
      | #WalletNotReadyError
      | #WalletLoadError
      | #WalletConfigError
      | #WalletConnectionError
      | #WalletDisconnectedError
      | #WalletDisconnectionError
      | #WalletAccountError
      | #WalletPublicKeyError
      | #WalletKeypairError
      | #WalletNotConnectedError
      | #WalletSendTransactionError
      | #WalletSignTransactionError
      | #WalletSignMessageError
      | #WalletSignInError
      | #WalletTimeoutError
      | #WalletWindowBlockedError
      | #WalletWindowClosedError
    ]

    type walletError = {
      name: string,
      message: string,
      stack: option<string>,
      error: error,
    }

    @module("@solana/wallet-adapter-react") @react.component
    external make: (
      ~localStorageKey: string=?,
      ~autoConnect: bool=?,
      ~wallets: array<adapter>,
      ~children: React.element,
      ~onError: walletError => unit=?,
    ) => React.element = "WalletProvider"
  }

  @val @module("@solana/wallet-adapter-react")
  external use: unit => contextState = "useWallet"
}

module Wallets = {
  @new @module("@solana/wallet-adapter-wallets")
  external phantomWalletAdapter: unit => adapter = "PhantomWalletAdapter"

  @new @module("@solana/wallet-adapter-wallets")
  external solflareWalletAdapter: {"network": cluster} => adapter = "SolflareWalletAdapter"

  @new @module("@solana/wallet-adapter-wallets")
  external torusWalletAdapter: unit => adapter = "TorusWalletAdapter"

  @new @module("@solana/wallet-adapter-wallets")
  external ledgerWalletAdapter: unit => adapter = "LedgerWalletAdapter"
}
