class User < ActiveRecord::Base 
    has_many :tickets
    has_many :events, through: :tickets

  def self.user_emails 
    self.all.map{|user| user.email}
  end 

  def self.find_by_email(user_email)
    user_emails.select{|email| email.include?(user_email)}
  end

  def self.user_passwords 
    self.all.map{|user| user.password}
  end 

    def ticket_summary
        i = 1
        self.tickets.map{ |ticket| "#{ticket.event.name} - #{ticket.event.location.city}" }
    end

    

end 


