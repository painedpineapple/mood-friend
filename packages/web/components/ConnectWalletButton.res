open Web3
open RescriptCore
open WebUtils

@react.component
let make = () => {
  let wallet = WalletAdapter.React_.use()
  Console.log(wallet)

  switch wallet.publicKey->Js.Nullable.toOption {
  | Some(publicKey) =>
    <div>
      <div> {`Connected with ${publicKey->PublicKey.toString}`->str} </div>
      <button> {"Disconnect"->str} </button>
    </div>
  | None =>
    <div>
      {wallet.wallets
      ->Array.filter(({readyState}) =>
        switch readyState {
        | #Installed
        | #Loadable => true
        | _ => false
        }
      )
      ->Array.map(({adapter}) => {
        <div key={adapter.name}>
          <button
            onClick={_ => {
              Console.log((adapter.name, "select"))
              wallet.select(adapter.name->Some)
            }}>
            {adapter.name->str}
          </button>
        </div>
      })
      ->arr}
    </div>
  }
}
