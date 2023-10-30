open WebUtils

@react.component
let make = () => {
  <Providers>
    <h1 className=%twc("text-center py-4 text-title")> {"MoodFriend"->str} </h1>
    <ConnectWalletButton />
  </Providers>
}
