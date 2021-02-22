class SessionsController < ApplicationController

  get '/signin' do 
    erb :"sessions/signin.html"
  end

  post '/signin' do
    user = User.find_by(username: params[:user][:username])
    if user && user.authenticate(params[:user][:password])
      session[:user_id] = user.id
      redirect "/users/#{user.id}"
    else
      flash[:error] = "Invalid log in information, please try again."
      redirect "/signin"
    end
  end

  get '/logout' do
    session.clear
    redirect '/'
  end
end
