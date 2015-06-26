require 'sinatra'
require 'sinatra/reloader'
require './shouter.rb'

set :port, 2501
set :bind, '0.0.0.0'

get ('/') do 
  @shouts = Shout.all
  @users = User.all
  erb :index
end

post ('/shout/new') do
  id = User.where("handle == '#{params[:handle]}'").first.id
  Shout.create message: params[:message], likes: 0, created_at: DateTime.now, user_id: id
  redirect ('/')
end