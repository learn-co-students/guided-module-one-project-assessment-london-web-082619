class User < ActiveRecord::Base 
    has_many :bookings
    has_many :events, through: :bookings

  def self.emails 
    self.all.map{|user| user.email}
  end 

  # def self.find_by_email(user_email)
  #   user_emails.select{|email| email.include?(user_email)}
  # end

  def self.user_passwords 
    self.all.map{|user| user.password}
  end 

  def booking_summary
    self.bookings.map{ |booking| "#{booking.event.name} - #{booking.event.location}" }
  end

    

end 


