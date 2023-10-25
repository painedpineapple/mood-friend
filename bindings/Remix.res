module Meta = {
  @module("@remix-run/react") @react.component
  external make: unit => React.element = "Meta"
}

module Outlet = {
  @module("@remix-run/react") @react.component
  external make: unit => React.element = "Outlet"
}

module Links = {
  @module("@remix-run/react") @react.component
  external make: unit => React.element = "Links"
}

module ScrollRestoration = {
  @module("@remix-run/react") @react.component
  external make: unit => React.element = "ScrollRestoration"
}

module Scripts = {
  @module("@remix-run/react") @react.component
  external make: unit => React.element = "Scripts"
}

module LiveReload = {
  @module("@remix-run/react") @react.component
  external make: (~port: int=?) => React.element = "LiveReload"
}

module CssBundle = {
  @module("@remix-run/css-bundle") @val
  external ref: string = "cssBundleHref"
}
