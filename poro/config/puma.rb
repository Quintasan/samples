directory '.'
rackup 'config.ru'
environment ENV.fetch('RACK_ENV', 'development')
threads 0, 8
bind "tcp://0.0.0.0:#{ENV.fetch('RACK_PORT', 9292)}"
