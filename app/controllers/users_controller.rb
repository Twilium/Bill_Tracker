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

  get '/bills/:id/homepagerecurring' do
    redirect_if_not_logged_in
    bill = Bill.find_by_id(params[:id])
    if bill.user == current_user
      bill.recurring = !bill.recurring
      bill.save
    end
    redirect "/users/homepage"
  end

  get '/users/:id/edit' do
    redirect_if_not_logged_in
    @user = User.find_by(id: params[:id])
    if @user != nil
      if @user == current_user
        erb :"/users/edit"
      else
        redirect "/users/homepage"
      end
    else
      redirect "/users/homepage"
    end
  end

  patch '/bills/:id' do
    redirect_if_not_logged_in
    user = user.find_by(id: params[:id])
    if user != nil
      if user == current_user
        if user.update(params[:user])
          flash[:success] = "User successfully updated!"
          redirect "/users/#{user.id}"
        else
          flash[:error] = "User was unsuccessfully updated, please try again"
          redirect "/users/#{user.id}/edit"
        end
      else
        redirect "/users/homepage"
      end
    else
      redirect "/users/homepage"
    end
  end

  delete '/users/:id' do
    user = User.find_by(id: params[:id])
    user.destroy
    redirect '/'
  end

end