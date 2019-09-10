class Location < ActiveRecord::Base 
    has_many :events

    def self.cities 
        self.all.map{|location| location.city}.uniq
    end 
end 