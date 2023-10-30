open Web3
open RescriptCore
open WebUtils

@react.component
let make = () => {
  let wallet = WalletAdapter.React_.use()

  switch wallet.publicKey->Js.Nullable.toOption {
  | Some(publicKey) =>
    <div className=%twc("p-4 flex flex-col content-center text-center")>
      <div> {"Connected with "->str} </div>
      <div> {`${publicKey->PublicKey.toString}`->str} </div>
      <button onClick={_ => wallet.disconnect()->ignore}> {"Disconnect"->str} </button>
    </div>
  | None =>
    <div className=%twc("p-4 flex flex-col content-center")>
      {wallet.wallets
      ->Array.filter(({readyState}) =>
        switch readyState {
        | #Installed
        | #Loadable => true
        | _ => false
        }
      )
      ->Array.map(({adapter}) => {
        <button
          key={adapter.name}
          onClick={_ => {
            wallet.select(adapter.name->Some)
          }}>
          {`Connect with ${adapter.name}`->str}
        </button>
      })
      ->arr}
    </div>
  }
}
