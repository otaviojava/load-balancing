import directors;  

sub vcl_recv {
    new bar = directors.round_robin();
    bar.add_backend(server1.backend());
    bar.add_backend(server2.backend());
    set req.backend_hint = bar.backend();
}