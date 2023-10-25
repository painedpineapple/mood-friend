%%raw(`
  import themeCss from "../web.css";

  export const links = () => [{ rel: "stylesheet", href: themeCss }]
`)

@react.component
let make = () => {
  <html lang="en">
    <head>
      <meta charSet="utf-8" />
      <meta name="viewport" content="width=device-width, initial-scale=1" />
      <Remix.Meta />
      <Remix.Links />
    </head>
    <body>
      // <Providers>
      <Remix.Outlet />
      // </Providers>
      <Remix.ScrollRestoration />
      <Remix.Scripts />
      <Remix.LiveReload />
    </body>
  </html>
}

// TODO:
// 1. live reload not working
// 2. setup solana wallet adapter
