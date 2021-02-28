require './config/environment'
require 'securerandom'
require_relative '../helpers/application_helper'
# require 'sinatra/flash'

class ApplicationController < Sinatra::Base
  include ApplicationHelper
  
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, ENV['SESSION_SECRET']
    register Sinatra::Flash
  end

  get "/" do
    if logged_in?
      redirect "/users/homepage"
    else
      erb :welcome
    end
  end

  helpers do
    def current_user
      @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    end

    def logged_in?
      !!current_user
    end

    def redirect_if_not_logged_in
      redirect "/signin" if !logged_in?
    end
  end

end
