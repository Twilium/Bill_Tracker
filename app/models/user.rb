class User < ActiveRecord::Base
    has_many :bills
    has_secure_password
end
