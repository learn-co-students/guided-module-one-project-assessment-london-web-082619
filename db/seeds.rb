
# require_relative '../config/environment.rb'

u1 = User.create({first_name: "Elizabeth", last_name: "Prendergast", email: "elizabeth.prendergast@gmail.com", password: "123456"})
u2 = User.create({first_name: "Michelle", last_name: "Van", email: "mjtvan@gmail.com", password: "123456"})

l1 = Location.create(city: "London")
l2 = Location.create(city: "Liverpool")

c1 = Category.create(name: "Music")
c2 = Category.create(name: "Theatre")

e1 = Event.create(name: "Opening Party", description: "The best party ever", location_id: Location.first.id, category_id: Category.first.id)
e2 = Event.create(name: "Closing Party", description: "The worst party ever", location_id: l2.id, category_id: l2.id)

t1 = Ticket.create(price: 25.00, user_id: u1.id, event_id: e1.id)
t2 = Ticket.create(price: 15.00, user_id: u2.id, event_id: e2.id)