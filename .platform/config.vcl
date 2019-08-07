backend serverA {
    .host = "server1.internal";
}
backend serverB {
    .host = "server2.internal";
}

sub vcl_init {
    new bar = directors.round_robin();
    bar.add_backend(serverA);
    bar.add_backend(serverB);
}

sub vcl_recv {
    # send all traffic to the bar director:
    set req.backend_hint = bar.backend();
}
