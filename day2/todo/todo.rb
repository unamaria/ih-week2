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
  @tasks = Task.sort_tasks
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
  def urgent?(name)
    name.include?("urgent")
  end
  def self.sort_tasks
    all_tasks = Task.all
    done_tasks = Task.where(:done => true )
    undone_urgent_tasks = all_tasks.select do |task| 
      task.urgent?(task.name) && task.done == false
    end
    other_tasks = all_tasks.reject do |task|
      task.done == true || task.urgent?(task.name)
    end

    undone_urgent_tasks.concat(other_tasks).concat(done_tasks)
  end
end

