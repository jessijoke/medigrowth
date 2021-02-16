require './config/environment'

class PostsController < ApplicationController
    get '/create_post' do
        if !logged_in?
            redirect to "/"
        else
            erb :"posts/create_post"
        end
    end

    post '/create_post' do
        if logged_in?
            if params[:condition] == "" || params[:rating] == ""
                erb :"posts/create_post", locals: {message: "Condition and Ratings field are required."}
            else
                @user_id = session[:user_id]
                @post = current_user.posts.build(condition: params[:condition].downcase.strip, rating: params[:rating], comments: params[:comments], user_id: @user_id)
                @post.save
                redirect to '/account'
            end
          else
            redirect to '/'
          end
    end

    get '/condition' do
        if logged_in?
            @user = User.find(session[:user_id])
            @conditions = @user.posts.map { |post| post.condition }.uniq
            erb :"posts/condition"
        else
            redirect to '/'
        end
    end

    get '/condition/:selection' do
        if logged_in?
            @user = User.find(session[:user_id])
            @entries = @user.posts.select { |post| post.condition == params[:selection] }
            erb :"posts/view_condition"
        else
            redirect to '/'
        end
    end

    get '/posts/:id/delete/:page' do
        if logged_in?
            @post = Post.find_by_id(params[:id])
            @post.delete
            redirect to "/#{params[:page]}"
        else
          redirect to "/"
        end
    end

    get '/posts/:id/edit' do
        if logged_in?
          @post = Post.find_by_id(params[:id])
          if @post && @post.user_id == session[:user_id]
            erb :'posts/edit'
          else
            redirect to '/account'
          end
        else
          redirect to '/'
        end
    end

    patch '/posts/:id' do
        if logged_in?
            if params[:condition] == "" || params[:rating] == ""
            redirect to "/posts/#{params[:id]}/edit"
            else
            @post = Post.find_by_id(params[:id])
                if @post && @post.user_id == session[:user_id]
                    if @post.update(condition: params[:condition].downcase.strip, rating: params[:rating], comments: params[:comments])
                    redirect to "/account"
                    else
                    redirect to "/account"
                    end
                else
                    redirect to '/account'
                end
            end
        else
            redirect to '/'
        end
    end

end
