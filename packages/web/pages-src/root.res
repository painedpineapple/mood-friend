@react.component
let make = () => {
  <html lang="en">
    <meta charSet="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <Remix.Meta />
    <Remix.Links />
    <body>
      <Providers> {"Home"->React.string} </Providers>
      <Remix.ScrollRestoration />
      <Remix.Scripts />
      <Remix.LiveReload />
    </body>
  </html>
}

let default = make
