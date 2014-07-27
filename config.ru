require 'bundler/setup'

Bundler.require

require './models/models'
require './app'
require 'openssl'
require 'uri'
require './lib/Base62.rb'


run JetFuel

