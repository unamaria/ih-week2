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

post '/task/add' do
  task = Task.new(params)
  task.save
  redirect('/')
end
#####

class Task < ActiveRecord::Base

end