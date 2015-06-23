require 'rubygems'
require 'active_record'
require 'sinatra'
require 'sinatra/reloader'

set :port, 5007
set :bind, '0.0.0.0'

ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: 'list.sqlite'
)

get ('/') do
  @students = Student.all
  erb :list
end

post ('/student/add') do
  Student.create(params)
  redirect('/')
end

post ('/student/:id/delete') do |student_id|
  student = Student.find(student_id)
  student.destroy
  redirect('/')
end

class Student < ActiveRecord::Base
  # we have name, surnames, birthday, website, number_of_dogs
  # and first_programming_experience

  # VALIDATORS
  AGE_MINIMUM = 16

  validate :proper_age, :complete_name, 
          :no_tas, :web_format
  # not using: :doggie, :before1970_nodogs

  private

  def doggie
    unless number_of_dogs > 0
      errors.add(:doggie, 'no dogs!')
    end
  end

  def web_format
    unless website.starts_with?('http:')
      errors.add(:website_format, 'wrong protocol')
    end
  end

  def proper_age
    unless birthday < AGE_MINIMUM.years.ago
      errors.add(:birthday, 'is too young')
    end
  end

  def complete_name
    unless name && surnames.length > 2
      errors.add(:complete_name, 'name or surname missing')
    end
  end

  def before1970_onedog
    unless birthday < Date.new(1970) && number_of_dogs < 2
      errors.add(:before1970_onedog, 'born after 1970 with more than one dog')
    end
  end

  def no_tas
    tas = ["Llorenç", "Sharon", "Nick"]
    if tas.include?(name)
      errors.add(:no_tas, 'ta, not student!')
    end
  end
end
