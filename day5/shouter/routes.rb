require 'sinatra'
require 'sinatra/reloader'
require './shouter.rb'

set :port, 2501
set :bind, '0.0.0.0'

get ('/') do 
  @shouts = Shout.all
  erb :index
end

post ('/shout/new') do
  redirect ('/')
end