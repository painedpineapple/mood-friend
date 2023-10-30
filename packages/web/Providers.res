@react.component
let make = (~children: React.element) => {
  <WalletAdapter.React_.ConnectionProvider endpoint={Env.solanaRpcUrl}>
    <WalletAdapter.React_.WalletProvider
      wallets=[
        WalletAdapter.Wallets.phantomWalletAdapter(),
        WalletAdapter.Wallets.solflareWalletAdapter({"network": Env.cluster}),
        WalletAdapter.Wallets.torusWalletAdapter(),
      ]>
      children
    </WalletAdapter.React_.WalletProvider>
  </WalletAdapter.React_.ConnectionProvider>
}
