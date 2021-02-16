require './config/environment'
require 'sinatra/flash'

class UsersController < ApplicationController
  get "users/homepage" do
    erb :"users/homepage"
  end
        
end