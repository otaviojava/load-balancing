sub vcl_init {
    new bar = directors.round_robin();
    bar.add_backend(server1.backend());
    bar.add_backend(server2.backend());

}

sub vcl_recv {
    
    set beresp.ttl = 0s;
    set beresp.grace = 0s;
    set req.backend_hint = bar.backend();
}