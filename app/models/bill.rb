class Bill < ActiveRecord::Base
    belongs_to :user
    validates :name, presence: true
    validates :amount, presence: true, numericality: {greater_than: 0}
    validates :category, presence: true
    validates :recurring, presence: true
    validates :due_date, presence: true
end
