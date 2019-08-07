import directors; 

sub vcl_recv {
    new bar = directors.round_robin();
    bar.add_backend(server1);
    bar.add_backend(server2);
}