class CreateBookings < ActiveRecord::Migration[5.2]
  def change
    create_table :bookings do |t| 
      t.integer :user_id 
      t.integer :event_id 
      t.integer :number
    end 
  end
end
