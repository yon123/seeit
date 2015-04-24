require 'sinatra'

get '/' do
  erb :'user/index'
end

get '/login' do
  erb :'user/login'
end

post '/login' do
  @user = User.where(email: params[:email]).first

  if @user && @user.password == params[:password]
    session[:user_id] = @user.id
    # redirect "/user/#{user.id}"
    redirect :"/user/search"
  else
    status 400
    @failed_login = true
    erb :"user/login"
  end
end

get '/signup' do
  @user = User.new
  erb :"user/signup"
end

post '/signup' do
  @user = User.new(
    name: params[:name],
    email: params[:email],
    password: params[:password],
    )
  if @user.save
    status 200
    session[:user_id] = @user.id
    redirect "/login"
  else
    status 400
    erb :"user/signup"

  end
end












# auth = https://api.vimeo.com/oauth/authorize
# access_token = https://api.vimeo.com/oauth/access_token
