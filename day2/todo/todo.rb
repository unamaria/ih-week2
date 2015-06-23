require 'rubygems'
require 'active_record'
require 'sinatra'
require 'sinatra/reloader'

##### DATABASE
set :port, 2007
set :bind, '0.0.0.0'

ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: 'todo.sqlite'
)
#####

##### ROUTES
get ('/') do
  @tasks = Task.all
  erb :index
end

post ('/task/add') do
  task = Task.new name: params[:name], done: false, date: DateTime.now
  task.save
  redirect('/')
end

post ('/task/:id/check') do |id|
  task = Task.find(id)
  task.done = true
  task.save
  redirect('/')
end

post ('/task/:id/delete') do |id|
  task = Task.find(id)
  task.destroy
  redirect('/')
end
#####

class Task < ActiveRecord::Base

end