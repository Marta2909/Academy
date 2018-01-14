require 'bundler'
require 'erb'
require 'digest'
require 'securerandom'

Bundler.require(:default)

require 'sinatra/reloader'
require 'sinatra/base'

enable :sessions

helpers do
  def encrypt(inputted_password)
    file = File.open('password.txt','r')
    line = file.read
    array = line.split(":")
    salt = array.first
    timestamp = array.last
    encrypted_password = Digest::SHA512.hexdigest(salt+'#'+inputted_password.to_s+'#'+timestamp)
  end

  def update_password(new_password)
    salt = SecureRandom.hex(10)
    timestamp = Time.now.getutc.to_i.to_s
    encrypted_password = Digest::SHA512.hexdigest(salt+'#'+new_password.to_s+'#'+timestamp)
    File.write('password.txt',salt+":"+encrypted_password+":"+timestamp)
  end
end

get '/' do
  if session[:username] == nil
    erb :change_password, { :locals => params }
  else
    redirect '/logged'
  end
end

post '/confirm_password' do
  redirect '/confirm_password'
end

get '/confirm_password' do
  erb :confirm_password, :locals => {:confirmed_password => params[:password] }
end

post '/logged' do
  if @inputted_password == @confirmed_password
    update_password(:confirmed_password)
    session[:username] = "zalogowano"
    redirect '/logged'
  else
    session[:username] = nil
    redirect '/'
  end
end

get '/logged' do
  erb :password_changed, { :locals => params }
end

get '/logout' do
   session.clear
   redirect '/'
end
