@val @scope(("import", "meta", "env"))
external solanaRpcUrl: string = "VITE_SOLANA_RPC_URL"

@val @scope(("import", "meta", "env"))
external isProd: bool = "PROD"

@val @scope(("import", "meta", "env"))
external isDev: bool = "DEV"

@val @scope(("import", "meta", "env"))
external mode: string = "MODE"

let cluster = switch (isDev, isProd) {
| (true, _) => #devnet
| (false, true) => #"mainnet-beta"
| (false, false) => #testnet
}
