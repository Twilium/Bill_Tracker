require './config/environment'
require 'sinatra/flash'

class UsersController < ApplicationController
  get "users/homepage" do
    erb :"users/homepage"
  end

  get '/signup' do
    erb :"users/signup"
  end

  post '/signup' do
    user = User.new(email: params[:user][:email], username: params[:user][:username], password: params[:user][:password])
    if user.save
      session[:user_id] = user.id
      redirect '/signin'
    else
      redirect '/signup'
    end
  end

end