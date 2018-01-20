# frozen_string_literal: true

workers Integer(ENV['WEB_CONCURRENCY'] || 2)
threads_count = Integer(ENV['RAILS_MAX_THREADS'] || 2)
threads threads_count, threads_count

preload_app!

rackup      DefaultRackup
port        ENV['PORT']     || 3000
environment ENV['RACK_ENV'] || 'development'

on_worker_boot { ActiveRecord::Base.establish_connection }

# Allow puma to be restarted by `rails restart` command.
plugin :tmp_restart
