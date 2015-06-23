# SL3. The online calculator

# We are in the Internet era, so everything goes online. We order stuff online, we watch TV shows online, we buy music online, we even
# change the world through Twitter… so why not calculating online? Does it make sense? (Einstein silently agrees).

# Decided: we will implement a simple calculator so first grade students can use it from their iPhones while doing their exams. You will think:
# "but iOS and Android have a built-in calculator! Are you crazy?”. Well, it definitely has, but OURS IS ONLINE!!!

# So, our Online Calculator will:
# * Have a home page (‘/‘) where you see all four available operations: add, substract, multiply and divide. Pretty simple stuff.
# * For each one of the available operations, we will have a form with two input fields and a button, which will go to another URL/route and
# display the result, like “The multiplication of 4 and 15 is 60” or “The addition of 10 and 39 is 49".
# * There will also be a link, in the home page, that goes to ‘/counting’ and should display the numbers from 1 to 200, one number per line.

# Feel free to add more features! :D

require 'sinatra'
require 'sinatra/reloader'

set :port, 3009
set :bind, '0.0.0.0'

get '/' do
  erb :index
end

get '/counting' do
  erb :counting
end

post '/result' do
  x = params[:firstvalue].to_i
  y = params[:secondvalue].to_i

  case params[:operation] # @txt_result = params[:operation] 
  when "Add"
    result = x + y
    @txt_result = "The sum of #{x} and #{y} is #{result}"
  when "Subtract"
    result = x - y
    @txt_result = "The subtraction of #{y} from #{x} is #{x - y}"
  when "Multiply"
    result = x * y
    @txt_result = "The multiplication of #{x} and #{y} is #{x * y}"
  when "Divide" 
    result = x / y
    @txt_result = "The division of #{x} by #{y} is #{x / y}"
  when "Operate result"
    @memory = IO.read('memory.txt')
  when "Erase memory"
    IO.write('memory.txt', '')
  end

  if result
    IO.write('memory.txt', result)
  end

  erb :index
end
