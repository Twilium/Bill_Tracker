require './config/environment'

class BillsController < ApplicationController
    configure do
        set :public_folder, 'public'
        set :views, 'app/views'
      end

      get '/bills/new' do
        erb :"/bills/new"
      end

      post '/bills' do
        bill = Bill.new(name: params[:bill][:name], amount: params[:bill][:amount], category: params[:bill][:category], recurring: params[:bill][:recurring], due_date: params[:bill][:due_date])
        
      end
end