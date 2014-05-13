require 'bundler/setup'

Bundler.require

require './models/models'
require './app'

DataMapper::Logger.new($stdout, :debug)
DataMapper.setup(:default, "postgres://postgres:rubyist12@localhost/Jetfuel")

run JetFuel

