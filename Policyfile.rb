name 'mumble'
default_source :community
cookbook 'mumble', path: '.'
run_list 'mumble::default'
named_run_list :server, 'mumble::server'
