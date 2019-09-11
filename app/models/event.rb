class Event < ActiveRecord::Base 
    has_many :bookings
    has_many :users, through: :bookings

    # Returns a formatted string of event info for an instance of Event
    def event_summary
        puts ""
        puts "Event Name: #{self.name}"
        puts "Date: #{self.start_time}" #NEED TO FORMAT THIS
        puts "Location: #{self.location.city}"
        puts "Category: #{self.category.name}"
        puts "Description: #{self.description}"
        puts ""
    end

    def self.names
        self.all.map{|eve| eve.name}
    end 
end 