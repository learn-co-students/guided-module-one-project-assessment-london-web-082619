class User < ActiveRecord::Base 
    has_many :tickets
    has_many :events, through: :tickets

    def view_tickets
        #Create array of strings which has ticket info
        # self.tickets
        # prompt = TTY::Prompt.new
        # prompt.select("", )
    
    end


end 


