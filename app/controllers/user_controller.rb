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
      flash[:login_failure] = "You failed to log in."
      redirect to "/login"
    end
  end

  get '/account' do
    if logged_in? && !is_a_doctor?
        @user = current_user

        erb :"users/account"
    else
        redirect to "/"
    end
  end

  get '/progress' do
    @user = current_user
    @entries = @user.posts
    @conditions = @user.posts.map { |post| post.condition }.uniq
    if logged_in? && !is_a_doctor?
        erb :"/posts/progress"
    else
        redirect to '/'
    end
  end

  get '/add_doctor' do
      if logged_in? && !is_a_doctor?
        @user = current_user
        @doctor = Doctor.find(@user.doctor_id).username if @user.doctor_id != 0 && @user.doctor_id != nil
        erb :"/users/add_doctor"
      else
        redirect to '/'
      end
  end

  patch '/add_doctor' do
    if logged_in? && !is_a_doctor?
            user = current_user
            if user && user.id == session[:user_id]
                if user.update(doctor_id: params[:doctor])
                redirect to "/add_doctor"
                else
                redirect to "/account"
                end
            end
    else
        redirect to '/'
    end
  end

  get '/logout' do
    session.clear
    redirect '/'
  end
end