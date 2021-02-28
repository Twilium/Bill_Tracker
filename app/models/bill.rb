class Bill < ActiveRecord::Base
    belongs_to :user
    validates :name, presence: true
    validates :amount, presence: true, numericality: {greater_than: 0}
    validates :category, presence: true
    validates_inclusion_of :recurring, in: [true, false]
    validates :due_date, presence: true
end
