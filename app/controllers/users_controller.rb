require './config/environment'
require 'sinatra/flash'

class UsersController < ApplicationController
  get "/users/:id" do
    redirect_if_not_logged_in
    @user = User.find_by_id(params[:id])
    if current_user != @user
      redirect "/users/#{current_user.id}"
    end
    @bill = @user.bills.last
    erb :"users/homepage"
  end

  get '/signup' do
    if logged_in?
      redirect "/users/homepage"
    else
      erb :"users/signup"
    end
  end

  post '/signup' do
    user = User.new(email: params[:user][:email], username: params[:user][:username], password: params[:user][:password])
    if user.save
      session[:user_id] = user.id
      flash[:succes] = "Account created successfully!"
      redirect '/signin'
    else
      flash[:error] = "Account sign up error: #{user.errors.full_messages.to_sentence}"
      redirect '/signup'
    end
  end

end