require './config/environment'

class DoctorsController < ApplicationController
    configure do
        set :erb, layout: :'doctor_layout'
    end

    get "/signup_doctor" do
        if !doctor_logged_in?
            erb :"/users/signup_doctor", :layout => false
        else
            redirect to '/doctor_account'
        end
      end
    
      post "/signup_doctor" do
        if params[:username] == "" || params[:password] == ""
             redirect 'failure'
        else
            @user = Doctor.new(username: params[:username], email: params[:email], password: params[:password], is_a_doctor: 1)
            @user.save
            session[:user_id] = @user.id
            redirect "/login_doctor"
        end
      end

      get "/login_doctor" do
        if !doctor_logged_in?
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

      get '/doctor_account' do
        if doctor_logged_in? && is_a_doctor?
            @doctor = Doctor.find(session[:user_id])
            @patients = User.select { |u| u.doctor_id == session[:user_id] }
            erb :"users/doctor_account"
        else
            redirect to "/"
        end
      end

      get '/patients' do
        if doctor_logged_in? && is_a_doctor?
            @doctor = Doctor.find(session[:user_id])
            @entries = User.select { |u| u.doctor_id == session[:user_id] }
            erb :"users/patients"
        else
            redirect to "/"
        end
      end

      patch '/patients/:id/edit' do
        if doctor_logged_in? && is_a_doctor?
            @user = User.find_by_id(params[:id])
            @doctor = Doctor.find_by_id(session[:user_id])
            if @user.doctor_id == current_user.id
              if @user && @doctor.id == session[:user_id]
                  if @user.update(doctor_id: nil)
                  redirect to "/patients"
                  else
                  redirect to "/patients"
                  end
              end
            else
              redirect to "/patient"
            end
        else
            redirect to '/'
        end
      end

    get '/patients/:id' do
      if doctor_logged_in? && is_a_doctor?
        #check  if patient belongs to doctor
        @user = User.find_by_id(params[:id])
        if @user.doctor_id == current_user.id
          @entries = @user.posts
          erb :"users/view_individual_patient"
        else
          redirect to "/patients"
        end
      else
        redirect to '/'
      end
    end

end