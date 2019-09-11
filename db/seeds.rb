
require_relative '../lib/api_communicator.rb'

u1 = User.create({first_name: "Elizabeth", last_name: "Prendergast", email: "elizabeth.prendergast@gmail.com", password: "123456"})
u2 = User.create({first_name: "Michelle", last_name: "Van", email: "mjtvan@gmail.com", password: "12345"})
u3 = User.create({first_name: "E", last_name: "P", email: "ep@gmail.com", password: "1"})

puts "#{User.all.length} users created"

rand_time = Time.new(rand(2019..2021), rand(1..12), rand(1..28), rand(14..22), 00)

e1 = Event.create(name: "Opening Party", description: "Lorem ipsum dolor sit amet, consectetur.", start_time: rand_time, location: "London", category: "Music")
e2 = Event.create(name: "Closing Party", description: "Lorem ipsum dolor sit amet, consectetur.", start_time: rand_time, location: "Glasgow", category: "Sports")
e3 = Event.create(name: "Les Miserables", description: "Suspendisse tincidunt dui sit amet imperdiet rhoncus.", start_time: rand_time, location: "Bath", category: "Music")
e4 = Event.create(name: "FIFA World Cup Party", description: "Suspendisse tincidunt dui sit amet imperdiet rhoncus.", start_time: rand_time, location: "London", category: "Other")
e5 = Event.create(name: "Blue Planet Live", description: "Vivamus euismod mauris vel nisl aliquet vehicula. ", start_time: rand_time, location: "Bristol", category:  "Music")
e6 = Event.create(name: "Wicked", description: "Vivamus euismod mauris vel nisl aliquet vehicula. ", start_time: rand_time, location: "Glasgow", category: "Other")

b1 = Booking.create(user_id: u1.id, event_id: e1.id, number: 3)
b2 = Booking.create(user_id: u2.id, event_id: e2.id, number: 2)
b3 = Booking.create(user_id: u1.id, event_id: e2.id, number: 1)


