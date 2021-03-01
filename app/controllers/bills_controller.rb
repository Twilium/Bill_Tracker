require './config/environment'

class BillsController < ApplicationController
    configure do
        set :public_folder, 'public'
        set :views, 'app/views'
      end

      get '/bills/new' do
        redirect_if_not_logged_in
        erb :"/bills/new.html"
      end

      get '/bills' do
        binding.pry
        redirect_if_not_logged_in
        @current_user_bills = current_user.bills
        erb :"/bills/index"
      end

      post '/bills' do
        redirect_if_not_logged_in
        bill = Bill.new(name: params[:bill][:name], amount: params[:bill][:amount], category: params[:bill][:category], recurring: params[:bill][:recurring], due_date: params[:bill][:due_date], user_id: session[:user_id])
        if bill.save
          redirect "/bills"
        else
          flash[:error] = "Invalid log in information, please try again."
          redirect "/bills/new"
        end
      end

      get '/bills/:id/recurring' do
        redirect_if_not_logged_in
        bill = Bill.find_by_id(params[:id])
        if bill.user == current_user
          bill.recurring = !bill.recurring
          bill.save
        end
        redirect "/bills"
      end

      get '/bills/:id' do
        binding.pry
        @bill = Bill.find_by_id(params[:id])
        erb :"/bills/show"
      end

      get '/bills/:id/edit' do
        redirect_if_not_logged_in
        @bill = Bill.find_by(id: params[:id])
        erb :"/bills/edit"
      end
    
      patch '/bills/:id' do
        redirect_if_not_logged_in
        binding.pry
        bill = Bill.find_by(id: params[:id])
        bill.update(name: params[:bill][:name])
        bill.update(amount: params[:bill][:amount])
        bill.update(category: params[:bill][:category])
        bill.update(recurring: params[:bill][:recurring])
        bill.update(due_date: params[:bill][:due_date])
        redirect "/bills"
      end

      delete '/bills/:id' do
        binding.pry
        bill = Bill.find_by(id: params[:id])
        bill.destroy
        redirect '/bills'
      end
end