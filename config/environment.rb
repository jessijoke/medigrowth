# ENV['SINATRA_ENV'] ||= "development"

require 'bundler/setup'
require 'sinatra/flash'
Bundler.require(:default)

configure :development do
    set :database, { adapter: 'sqlite3', database: 'db/development.sqlite3' }
    set :show_exceptions, true
  end
  
configure :production do
    db = URI.parse(ENV['DATABASE_URL'] || 'postgres:///localhost/medigrowth')
  
    ActiveRecord::Base.establish_connection(
      adapter: db.scheme == 'postgres' ? 'postgresql' : db.scheme,
      host: db.host,
      username: db.user,
      password: db.password,
      database: db.path[1..-1],
      encoding: 'utf8'
    )
  end

require './app/controllers/application_controller'
require './app/controllers/doctor_controller'
require './app/controllers/user_controller'
require_all 'app'