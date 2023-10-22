open Bun

serve(
  serveConfig(
    ~fetch=_req => Http.Response.make("Bun!"),
    ~port=4000,
    ~tls=tlsConfig(
      ~key=file("../https-cert/localhost-key.pem"),
      ~cert=file("../https-cert/localhost.pem"),
      (),
    ),
    (),
  ),
)
