ENV['SINATRA_ENV'] ||= "development"

require 'bundler/setup'
require 'sinatra/flash'
Bundler.require(:default, ENV['SINATRA_ENV'])

require './app/controllers/application_controller'
require './app/controllers/doctor_controller'
require './app/controllers/user_controller'
require_all 'app'
