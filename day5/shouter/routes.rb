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

get ('/signup') do
  erb :signup
end

post ('/signup') do
  new_user = User.create name: params[:name], handle: params[:handle], password: params[:password]
  session[:handle] = new_user.handle
  redirect('/')
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

get ('/top_handles') do
  @users_likes = {}
  User.all.each do |user|
    user_shouts = Shout.where(user_id: user.id)
    total_likes = user_shouts.inject(0) { |total_likes, shout| total_likes += shout.likes }
    @users_likes[user.handle] = total_likes
  end
  @users_likes = @users_likes.sort_by { |handle, likes| likes }.reverse
  erb :top_handles
end




