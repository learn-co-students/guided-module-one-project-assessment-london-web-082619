class Event < ActiveRecord::Base 
    belongs_to :location
    belongs_to :category
    has_many :tickets
    has_many :users, through: :tickets

    # Returns a formatted string of event info for an instance of Event
    def event_summary
        puts "Event Name: #{self.name}"
        puts "Date: #{self.start_time}" #NEED TO FORMAT THIS
        puts "Location: #{self.location.city}"
        puts "Category: #{self.category.name}"
        puts "Description: #{self.description}"
    end

    def self.names
        self.all.map{|eve| eve.name}
    end 
end 