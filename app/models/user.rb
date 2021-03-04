class User < ActiveRecord::Base
    has_many :bills
    has_secure_password
    validates :password, length: {in: 6..20}, confirmation: true
    validates :username, uniqueness: true, length: {in: 4..25}, exclusion: {in: %w(admin superadmin user)}
    validates :email, presence: true, uniqueness: true, format: {with: /\A(?<username>[^@\s]+)@((?<domain_name>[-a-z0-9]+)\.(?<domain>[a-z]{2,}))\Z/i}
end