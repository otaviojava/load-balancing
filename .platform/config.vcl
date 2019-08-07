sub vcl_init {
    new bar = directors.random();
    bar.add_backend(server1.backend(),1.0);
    bar.add_backend(server2.backend(), 1.0);
}

sub vcl_recv {
    set req.backend_hint = bar.backend();
}