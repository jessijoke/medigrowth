require './config/environment'

class UsersController < ApplicationController

  get "/" do
    erb :index, :layout => false
  end

  get "/signup" do
    if !logged_in?
        erb :"/users/signup", :layout => false
    else
        redirect to '/account'
    end
  end

  post "/signup" do
    if params[:username] == "" || params[:password] == ""
      redirect 'failure'
    else
      @user = User.new(username: params[:username], email: params[:email], password: params[:password])
      @user.save
      session[:user_id] = @user.id
      redirect "/login"
    end
  end

  get "/login" do
    if !logged_in?
        erb :"/users/login", :layout => false
    else
        redirect to '/account'
    end
  end

  post "/login" do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect to "/account"
    else
      redirect to "/failure"
    end
  end

  get '/account' do
    @user = User.find(session[:user_id])
    erb :"users/account"
  end

  get '/logout' do
    session.clear
    redirect '/'
  end
end