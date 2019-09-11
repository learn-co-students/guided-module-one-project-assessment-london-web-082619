
require_relative '../lib/api_communicator.rb'

u1 = User.create({first_name: "Elizabeth", last_name: "Prendergast", email: "elizabeth.prendergast@gmail.com", password: "123456"})
u2 = User.create({first_name: "Michelle", last_name: "Van", email: "mjtvan@gmail.com", password: "12345"})
u3 = User.create({first_name: "E", last_name: "P", email: "ep@gmail.com", password: "1"})

puts "#{User.all.length} users created"

l1 = Location.create(city: "London")
l2 = Location.create(city: "Liverpool")
l3 = Location.create(city: "Edinburgh")

c1 = Category.create(name: "Music")
c2 = Category.create(name: "Theatre")
c3 = Category.create(name: "Sports")

rand_time = Time.new(rand(2019..2021), rand(1..12), rand(1..28), rand(14..22), 00)

e1 = Event.create(name: "Opening Party", description: "Lorem ipsum dolor sit amet, consectetur.", start_time: rand_time, location_id: l1.id, category_id: c1.id)
e2 = Event.create(name: "Closing Party", description: "Lorem ipsum dolor sit amet, consectetur.", start_time: rand_time, location_id: l2.id, category_id: c1.id)
e3 = Event.create(name: "Les Miserables", description: "Suspendisse tincidunt dui sit amet imperdiet rhoncus.", start_time: rand_time, location_id: l3.id, category_id: c2.id)
e4 = Event.create(name: "FIFA World Cup Party", description: "Suspendisse tincidunt dui sit amet imperdiet rhoncus.", start_time: rand_time, location_id: l1.id, category_id: c3.id)
e5 = Event.create(name: "Blue Planet Live", description: "Vivamus euismod mauris vel nisl aliquet vehicula. ", start_time: rand_time, location_id: l2.id, category_id: c1.id)
e6 = Event.create(name: "Wicked", description: "Vivamus euismod mauris vel nisl aliquet vehicula. ", start_time: rand_time, location_id: l3.id, category_id: c2.id)

t1 = Booking.create(user_id: u1.id, event_id: e1.id, number: 3)
t2 = Booking.create(user_id: u2.id, event_id: e2.id, number: 2)
t3 = Booking.create(user_id: u1.id, event_id: e2.id, number: 1)


