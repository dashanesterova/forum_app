# require 'json'
require 'pry'
require 'sinatra/base'
require 'sinatra/reloader'
require 'pg'
require 'bcrypt'

require_relative 'server'
use Rack::MethodOverride

run FORUM_APP::Server
