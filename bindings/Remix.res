module Meta = {
  @module("@remix-run/react") @react.component
  external make: unit => React.element = "Meta"
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
  external make: unit => React.element = "LiveReload"
}
