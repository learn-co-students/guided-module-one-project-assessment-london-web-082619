# require_relative "../lib/command_line_start.rb"
# $prompt = TTY::Prompt.new


# def main_menu
#     prompt = TTY::Prompt.new
#     selection = $prompt.select("Please select an option from the menu below", ["Search events", "View my tickets", "Log out"])
#     if selection == "Search events"
#         search
#     elsif selection == "View my tickets"
#         ticket_summary = $current_user.ticket_summary
#         my_tickets_navigation(ticket_summary)
#     elsif selection == "Log out"
#         puts "Returns to sign in page"
#     else
#         return "ERROR"
#     end
# end

# # def search_menu
# #     $prompt.select("How would you like to search available events?", ["By name", "By location", "By category", "Return to main menu"])
# # end

# # def my_tickets_menu(ticket_summary)
# #     selection = $prompt.select("You currently have #{User.first.tickets.length} event ticket(s). Please click on a ticket to see more about that event.", ticket_summary)
# #     my_tickets_navigation(selection)
# # end

# def main_menu_navigation(selection)
#     if selection == "Search events"
#         search_menu
#     elsif selection == "View my tickets"
#         ticket_summary = $current_user.ticket_summary
#         my_tickets_menu(ticket_summary)
#     elsif selection == "Log out"
#         exit
#     else
#         return "ERROR"
#     end
# end

# def my_tickets_navigation(ticket_summary)
#     selection = $prompt.select("You currently have #{$current_user.tickets.length} event ticket(s). Please click on a ticket to see more about that event.", ticket_summary)
#     # Given a selection from my_tickets_menu, return a summary of that event
#     #Example selection (string): Opening Party - London
#     event_name = selection.split(" - ")[0]
#     event_city = selection.split(" - ")[1]
#     location_id = Location.find_by(city: event_city).id
#     event = Event.find_by(name: event_name, location_id: location_id )
#     event.event_summary
#     event_summary_navigation
# end

# def event_summary_menu
#     $prompt.select("Actions:", ["View My Bookings", "Modify My Bookings", "Main Menu"])
# end

# def event_summary_navigation

#     selection = event_summary_menu

#     if selection == "View My Bookings"
#         ticket_summary = $current_user.ticket_summary
#         my_tickets_menu(ticket_summary)

#     elsif selection = "Modify My Bookings"
#         input = $prompt.select("Which booking would you like to change?", ticket_summary)
#         action = $prompt.select("Actions: ", ["Change Quantity", "Refund Ticket"])

#         case action 

#         when "Change Quantity"
#             event_name = ticket_summary.split(" - ")[0]
#             new_num = $prompt.ask("Updated Total Number of Tickets You Wish to Book for This Event: ")
#             selected_ticket = Ticket.find_by(name: event_name.id, user_id: $current_user.id)
#             Ticket.update(price: selected_ticket.price, user_id: $current_user.id, event_id: event_name.id, number: new_num)
#             puts "Updated"
#             event_summary_menu

#         when "Refund All Bookings"
#             Ticket.where("user_id = ?", $current_user.id).destroy_all #check
#             puts "You have no bookings."
#             event_summary_menu

#         else selection == "Main Menu"
#         main_menu

#     else
#         "That is not a valid input!"
#     end

# end
