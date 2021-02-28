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
        @current_user_bills = current_user.bills
        erb :"/bills/show"
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

      get '/bills/:id/edit' do
        @bill = Bill.find_by(id: params[:id])
        erb :"/bills/edit"
      end
    
      patch '/bills' do
        bill = Bill.find_by(id: params[:id])
        bill.update(name: params[:bill][:name])
        bill.update(name: params[:bill][:amount])
        bill.update(name: params[:bill][:category])
        bill.update(name: params[:bill][:recurring])
        bill.update(name: params[:bill][:due_date])
        redirect "/bills"
      end
end