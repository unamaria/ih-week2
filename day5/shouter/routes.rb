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
  @current_user = User.find(session[:id]).handle if session[:id]
  erb :index
end

get ('/signup') do
  erb :signup
end

post ('/signup') do
  new_user = User.create name: params[:name], handle: params[:handle], password: params[:password]
  session[:id] = new_user.id
  redirect('/')
end

post ('/login') do
  User.all.each do |user|
    if params[:handle] == user.handle 
      session[:id] = User.find_by_handle params[:handle]
      if User.find(session[:id]).password == params[:password]
        redirect('/')
      end
    else
      redirect('/')
    end
  end  
end

post ('/logout') do
  session.clear
  redirect('/')
end

post ('/shout/new') do
  user = User.find(session[:id])
  shout = Shout.new message: params[:message], likes: 0, created_at: DateTime.now
  shout.user = user
  shout.save
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
  @current_user = User.find(session[:id]).handle if session[:id]
  @best_shouts = Shout.order("likes DESC")
  erb :best
end

get ('/shouts/:handle') do |handle|
  @users = User.all
  @current_user = User.find(session[:id]).handle if session[:id]
  @shouts_by_handle = (User.find_by_handle handle).shouts
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
