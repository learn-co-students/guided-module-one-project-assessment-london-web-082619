class Event < ActiveRecord::Base 
    belongs_to :location
    belongs_to :category
    has_many :tickets
    has_many :users, through: :tickets
end 