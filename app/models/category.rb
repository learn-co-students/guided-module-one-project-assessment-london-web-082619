class Category < ActiveRecord::Base 
    has_many :events

    def self.names 
        self.all.map{|cat| cat.name}.uniq
    end 

   
end 
