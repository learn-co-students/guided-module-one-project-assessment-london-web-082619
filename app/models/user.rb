class User < ActiveRecord::Base 
    has_many :tickets
    has_many :events, through: :tickets

    # returns an array of strings, "<event_name> - <event_location>", for the tickets which belong to this user
    def ticket_summary
        i = 1
        self.tickets.map{ |ticket| "#{ticket.event.name} - #{ticket.event.location.city}" }
    end

    

end 


