require 'bundler/setup'

Bundler.require

require './models/models'
require './app'
require 'openssl'
require 'uri'
require './lib/Base62.rb'

DataMapper::Logger.new($stdout, :debug)
DataMapper.setup(:default, "postgres://postgres:rubyist12@localhost/Jetfuel")

run JetFuel

