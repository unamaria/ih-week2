require 'rubygems'
require 'active_record'

ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: 'shouter.sqlite'
)

class User < ActiveRecord::Base
  validates_presence_of :name, :handle, :password
  validates :handle, uniqueness: true
  validates :password, uniqueness: true, length: { is: 8 }
  has_many :shouts

  # def total_likes
  #   # user = User.find_by handle: session[:handle]
  #   # own_shouts = Shout.where(user_id == user.id)
  #   # own_shouts.reduce { |total_likes, shout| total_likes + shout.likes }
  #   shouts.reduce { |total_likes, shout| total_likes + shout.likes }
  # end
end

class Shout < ActiveRecord::Base
  validates_presence_of :user_id
  validates :likes, numericality: { greater_than_or_equal_to: 0, only_integer: true }
  validates :message, length: { maximum: 200 }
  belongs_to :user
end
