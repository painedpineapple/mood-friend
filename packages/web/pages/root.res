%%raw(`
  import themeCss from "../../../styles/styles.build.css";
  import { cssBundleHref } from "@remix-run/css-bundle";

  export const links = () => [
    { rel: "stylesheet", href: themeCss },
    ...[cssBundleHref ? [{ rel: "stylesheet", href: cssBundleHref }] : []]
    ]
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
      <div className=%twc("p-test bg-blue")>
        {"helloo8"->React.string}
        <Remix.Outlet />
      </div>
      <Remix.ScrollRestoration />
      <Remix.Scripts />
      <Remix.LiveReload />
    </body>
  </html>
}

// TODO:
// 2. setup solana wallet adapter
