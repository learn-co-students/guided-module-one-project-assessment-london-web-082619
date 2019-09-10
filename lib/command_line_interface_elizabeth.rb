require_relative "../lib/command_line_start.rb"
$prompt = TTY::Prompt.new

def main_menu
    prompt = TTY::Prompt.new
    selection = $prompt.select("Please select an option from the menu below", ["Search events", "View my tickets", "Log out"])
    if selection == "Search events"
        search
    elsif selection == "View my tickets"
        ticket_summary = User.first.ticket_summary
        display_tickets(ticket_summary)
    elsif selection == "Log out"
        puts "Returns to sign in page"
    else
        return "ERROR"
    end
end

def search_menu
    $prompt.select("How would you like to search available events?", ["By name", "By location", "By category", "Return to main menu"])
end

def display_tickets(ticket_summary)
    prompt = TTY::Prompt.new
    selection = prompt.select("You currently have #{User.first.tickets.length} event ticket(s). Please click on a ticket to see more about that event.", ticket_summary)
    #Example selection (string): Opening Party - London
    event_name = selection.split(" - ")[0]
    event_city = selection.split(" - ")[1]
    location_id = Location.find_by(city: event_city).id
    event = Event.find_by(name: event_name, location_id: location_id )
    event.event_summary
end

# def main_menu_navigation(selection)
#     if selection == "Search events"
#         search
#     elsif selection == "View my tickets"
#         ticket_summary = User.first.ticket_summary
#         display_tickets(ticket_summary)
#     elsif selection == "Log out"
#         puts "Returns to sign in page"
#     else
#         return "ERROR"
#     end
# end
