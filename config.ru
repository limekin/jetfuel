require 'bundler/setup'

Bundler.require

DataMapper::Logger.new($stdout, :debug)
DataMapper.setup(:default, ENV["DATABASE_URL"])

require './models/models'
require './app'
require 'openssl'
require 'uri'
require './lib/Base62.rb'


run JetFuel

