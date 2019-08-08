sub vcl_init {
    new bar = directors.round_robin();
    bar.add_backend(server1.backend());
    bar.add_backend(server2.backend());
}

sub vcl_fetch {
  set beresp.http.Cache-Control = "max-age=0";
  set beresp.ttl = 0s;
  set beresp.grace = 0s;
}

sub vcl_recv {
    set req.backend_hint = bar.backend();
}