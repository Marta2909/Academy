require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/flash'
require_relative 'logic'

ROWS = 20
COLUMNS = 50

enable :sessions

get '/' do
  erb :index
end

post '/next' do
  if params[:checked_cell] != nil
    lc = categorize_cells(params[:checked_cell]).first
    dc = categorize_cells(params[:checked_cell]).last
    params[:checked_cell] = decide_the_next_iteration(lc, dc)
    erb :next
  else
    flash[:notice] = "Wszystkie komórki umarły. Zaczynamy nową grę"
    redirect '/'
  end
end
