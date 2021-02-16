require './config/environment'

class BillsController < ApplicationController
    configure do
        set :public_folder, 'public'
        set :views, 'app/views'
      end

      get '/bills/new' do
        erb :"/bills/new"
      end
end