import cookie;
import header;

sub vcl_init {
    new bar = directors.hash();
    bar.add_backend(server1.backend(), 1);
    bar.add_backend(server2.backend(), 1);
}

sub vcl_recv {
    cookie.parse(req.http.cookie);
    if (cookie.get("sticky")) {
      set req.http.sticky = cookie.get("sticky");
    } else {
    # The cookies will have floats in them.
    # Whatever, ehh, floats your boat can be used.
    set req.http.sticky = std.random(1, 100);
  }
  # use to be client.identity in V3
  set req.backend_hint = cdir.backend(req.http.sticky);
}

sub vcl_deliver {
  # persist the cookie
  # we need to use the header vmod as there might be a set-cookie
  # header on the object already and
  # we don't want to mess with it
  if (req.http.sticky) {
     header.append(resp.http.Set-Cookie,"sticky=bar" +

            req.http.sticky + ";   Expires=" + cookie.format_rfc1123(now, 60m));

   }
}