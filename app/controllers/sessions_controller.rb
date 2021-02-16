class SessionsController < ApplicationController

  get '/signin' do 
    erb :"sessions/signin"
  end

  post '/homepage' do
    user = User.find_by(username: params[:user][:username])
    if user && user.authenticate(params[:user][:password])
      session[:user_id] = user.id
      redirect "users/homepage"
    else
      redirect "/signin"
    end
  end
end
