require './config/environment'

class BillController < Sinatra::Base
    configure do
        set :public_folder, 'public'
        set :views, 'app/views'
      end
end