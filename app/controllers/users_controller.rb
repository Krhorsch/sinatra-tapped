require 'rack-flash'
class UsersController < ApplicationController
  use Rack::Flash

  get '/signup' do
    if !logged_in?
      erb :"users/create_user"
    else
      redirect to  "/users/:id"
    end
  end

  post '/signup' do
    if !params["username"].empty? && !params["password"].empty? && !params["email"].empty?
      if !User.all_usernames.include?(params["username"]) && !User.all_emails.include?(params["email"])
        @user = User.create(username: params["username"], password_digest: params["password"], email: params["email"])
        session[:user_id] = @user.id
        erb :"users/show"
      else
        flash[:message] = "The username or email you have chosen is not unique"
        redirect to '/signup'
      end
    else
      flash[:message] = "Make sure all fields are filled out"
      redirect to '/signup'
    end
  end

  get '/login' do
    if !logged_in?
      erb :"users/login"
    else
      redirect to "/users/:id"
    end
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    if @user
      session[:user_id] = @user.id
      redirect to "/users/:id"
    else
      redirect to "/login"
    end
  end

  get '/logout' do
    if logged_in?
      session.clear
      redirect to '/login'
    else
      redirect to '/'
    end
  end

  get '/users/:id' do
      @user = current_user
      erb :"/users/show"
  end
end
