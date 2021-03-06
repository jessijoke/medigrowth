require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "growing_a_better_life"
    register Sinatra::Flash
  end

  get "/failure" do
    erb :failure
  end


  helpers do

    def logged_in?
      !!current_user
    end

    def current_user
        @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    end

    def doctor_logged_in?
      !!current_doctor
    end

    def current_doctor
        @current_user ||= Doctor.find_by(id: session[:user_id]) if session[:user_id]
    end

    def is_a_doctor?
      #binding.pry
      if current_user.is_a_doctor == 1
        true
      else
        false
      end
    end
    
  end
end
