name 'mumble'
default_source :community
cookbook 'mumble', path: '.'
run_list 'mumble::default'
