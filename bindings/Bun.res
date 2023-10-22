type t

@deriving(abstract)
type tlsConfig = {
  key: string,
  cert: string,
  @optional
  passphrase: string,
  @optional
  ca: string,
  @optional
  dhParamsFile: string,
}

@deriving(abstract)
type serveConfig = {
  fetch: Http.Request.t => Http.Response.t,
  @optional
  port: int,
  @optional
  hostname: string,
  @optional
  unix: string,
  @optional
  development: bool,
  @optional
  error: exn => Http.Response.t,
  @optional
  tls: tlsConfig,
}

@val @scope("Bun")
external serve: serveConfig => unit = "serve"

@val @scope("Bun")
external file: string => string = "file"
