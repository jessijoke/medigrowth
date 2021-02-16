require './config/environment'

class DoctorsController < ApplicationController
    get "/signup_doctor" do
        if !logged_in?
            erb :"/users/signup_doctor", :layout => false
        else
            redirect to '/doctor_account'
        end
      end
    
      post "/signup_doctor" do
        if params[:username] == "" || params[:password] == ""
             redirect 'failure'
        else
            @user = Doctor.new(username: params[:username], email: params[:email], password: params[:password])
            @user.save
            session[:user_id] = @user.id
            redirect "/login_doctor"
        end
      end

      get "/login_doctor" do
        if !logged_in?
            erb :"/users/login_doctor", :layout => false
        else
            redirect to '/doctor_account'
        end
      end
    
      post "/login_doctor" do
        @user = Doctor.find_by(username: params[:username])
        if @user && @user.authenticate(params[:password])
          session[:user_id] = @user.id
          redirect to "/doctor_account"
        else
          redirect to "/failure"
        end
      end

      get '/account_doctor' do
        @user = Doctor.find(session[:user_id])
        erb :"users/doctor_account"
      end
end