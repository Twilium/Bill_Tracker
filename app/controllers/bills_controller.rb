require './config/environment'

class BillsController < ApplicationController
    configure do
        set :public_folder, 'public'
        set :views, 'app/views'
      end

      get '/bills/new' do
        redirect_if_not_logged_in
        erb :"/bills/new"
      end

      post '/bills' do
        bill = Bill.new(name: params[:bill][:name], amount: params[:bill][:amount], category: params[:bill][:category], recurring: params[:bill][:recurring], due_date: params[:bill][:due_date], user_id: session[:user_id])
        if bill.save
          binding.pry
          redirect "/bills/all"
        else
          flash[:error] = "Invalid log in information, please try again."
          redirect "'/bills/new"
        end
      end
end