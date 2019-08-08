sub vcl_init {
    new bar = directors.round_robin();
    bar.add_backend(server1.backend());
    bar.add_backend(server2.backend());
}

sub vcl_fetch {
  set beresp.ttl = 0s;
  set beresp.grace = 0s;
  set beresp.stale_if_error = 0s;
  set beresp.stale_if_error = 48h;
}

sub vcl_recv {
    set req.backend_hint = bar.backend();
}