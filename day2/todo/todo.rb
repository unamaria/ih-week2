require 'sinatra'
require 'sinatra/reloader'

require './lib/task.rb'

set :port, 2005
set :bind, '0.0.0.0'

tasks ||= []
id = 0

get '/' do
  @tasks = tasks
  erb :index
end

get '/new_task' do
  erb :new_task
end

post '/new_task' do
  id += 1
  tasks << Task.new(id, params[:task])
  redirect('/')
end