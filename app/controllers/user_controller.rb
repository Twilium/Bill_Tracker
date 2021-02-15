require './config/environment'

class UserController < Sinatra::Base
    configure do
        set :public_folder, 'public'
        set :views, 'app/views'
        enable :sessions
        set :session_secret, ENV['SESSION_SECRET']
      end

      get '/signin' do 
        binding.pry
        erb :"users/signin"
      end

      post '/homepage' do
        user = User.find_by(username: params[:username])
        if user && user.authenticate(params[:password])
            session[:user_id] = user.id
            redirect "users/homepage"
        else
            redirect "/signin"
        end
      end
end