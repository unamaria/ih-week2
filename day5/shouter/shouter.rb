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
end

class Shout < ActiveRecord::Base
  validates_presence_of :user_id
  validates :likes, numericality: { greater_than_or_equal_to: 0, only_integer: true }
  validates :message, length: { maximum: 200 }
  belongs_to :user
end



# -------------- TESTS ------------------ #

describe User do
  
  before do
    @sharon = User.new
    @sharon.name = "Sharon"
    @sharon.handle = "sharebear"
    @sharon.password = "12345678"
  end

  it "should be valid with correct data" do
    @rufus = User.new name: "Rufus", handle: "rufustheking", password: "abcd1256"
    expect(@rufus.valid?).to be_truthy
  end

  describe :name do
    it "should be invalid with no name" do
      @sharon.name = nil
      expect(@sharon.valid?).to be_falsy
    end
  end

  describe :handle do
    it "should be invalid with no handle" do
      @sharon.handle = nil
      expect(@sharon.valid?).to be_falsy
    end
    it "should be invalid if not unique" do
      @sharon.save
      @karen = User.new
      @karen.name = "karen"
      @karen.handle = "sharebear"
      @karen.password = "27463927" 
      expect(@karen.valid?).to be_falsy
    end
  end

  describe :password do
    it "should be invalid when not present" do
      @sharon.password = nil
      expect(@sharon.valid?).to be_falsy
    end
    it "should be invalid when not unique" do
      @karen = User.new
      @karen.name = "karen"
      @karen.handle = "karen3"
      @karen.password = "12345678" 
      expect(@karen.valid?).to be_falsy
    end
    it "should be invalid if not 8 characters long" do
      @sharon.password = "abc"
      expect(@sharon.valid?).to be_falsy
    end
  end
end

describe Shout do
  before do
    @shout = Shout.new user_id: 4
  end

  describe :user_id do
    it "should be invalid when no present" do
      @shout.user_id = nil
      expect(@shout.valid?).to be_falsy
    end
  end

  describe :message do
    it "should be invalid if longer than 200 characters" do
      @shout.message = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec suscipit ultricies enim non fringilla. Phasellus semper fermentum elementum. Proin non blandit velit, a elementum ex. Quisque turpis duis."
      expect(@shout.valid?).to be_falsy
    end
  end

  describe :likes do
    it "should be an integer" do
      @shout.likes = "pou"
      expect(@shout.valid?).to be_falsy
    end
    it "should be equal or bigger than 0" do
      @shout.likes = -2
      expect(@shout.valid?).to be_falsy
    end
  end
end

