require 'sinatra'
require 'sinatra/reloader'
require './shouter.rb'
require 'pry'

set :port, 2501
set :bind, '0.0.0.0'

enable :sessions

get ('/') do 
  @shouts = Shout.all
  @users = User.all
  @current_user = session[:handle]
  erb :index
end

post ('/login') do
  session[:handle] = params[:handle]
  session[:password] = params[:password]
  redirect('/')
end

post ('/logout') do
  session.clear
  redirect('/')
end

post ('/shout/new') do
  id = (User.find_by handle: session[:handle]).id
  Shout.create message: params[:message], likes: 0, created_at: DateTime.now, user_id: id
  redirect ('/')
end

post ('/:id/like') do |id|
  shout = Shout.find(id)
  shout.likes += 1
  shout.save
  redirect('/')
end

get ('/best') do
  @users = User.all
  @current_user = session[:handle]
  @best_shouts = Shout.all.sort_by { |shout| shout.likes }.reverse
  erb :best
end

get ('/shouts/:handle') do |handle|
  @users = User.all
  @current_user = session[:handle]
  @handle = handle
  id = (User.find_by_handle handle).id
  @shouts_by_handle = Shout.where(user_id: id)
  erb :shouts_by_handle
end

get ('/signup') do
  erb :signup
end

post ('/signup') do
  User.create name: params[:name], handle: params[:handle], password: params[:password]
  redirect('/')
end




