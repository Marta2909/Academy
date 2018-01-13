
require 'bundler'
require 'erb'
require 'digest'

Bundler.require(:default)

require 'sinatra/reloader'
require 'sinatra/base'


enable :sessions

helpers do
  def checkpassword(inputted_password)
    saved_password = File.open('password.txt','r')
    array = saved_password.read.split(":")
    salt_string = array.first
    timestamp_string = array.last.chomp("\n\n")
    hashed_password_from_file = Digest::SHA512.hexdigest(salt_string+'#'+'password'+'#'+timestamp_string)

    hashed_inputted_password = Digest::SHA512.hexdigest(salt_string+'#'+inputted_password.to_s+'#'+timestamp_string)

    if hashed_inputted_password == hashed_password_from_file
      true
    else
      false
    end
  end
end

get '/' do
  if session[:username] == nil
    erb :log_in, { :locals => params }
  else
    redirect '/logged'
  end
end

post '/logged' do
  if checkpassword(params[:password]) == true
    session[:username] = "zalogowano"
    redirect '/logged'
  else
    session[:username] = nil
    redirect '/'
  end
end

get '/logged' do
  erb :log_out, { :locals => params }
end

post '/' do
   session.clear
   redirect '/'
end
