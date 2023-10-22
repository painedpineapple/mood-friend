module Request = {
  type t = {url: string}
}

module Response = {
  type t = {body: string}

  @new("Response")
  external make: string => t = ""
}
