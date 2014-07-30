require 'bundler/setup'

Bundler.require

DataMapper::Logger.new($stdout, :debug)
DataMapper.setup(:default, ENV["DATABASE_URL"] || "postgres://postgres:rubyist12@localhost/Jetfuel")

require './models/models'
require './app'
require 'openssl'
require 'uri'
require './lib/Base62.rb'


run JetFuel

