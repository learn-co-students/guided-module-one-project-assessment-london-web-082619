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

def my_tickets_menu(ticket_summary)
    selection = $prompt.select("You currently have #{User.first.tickets.length} event ticket(s). Please click on a ticket to see more about that event.", ticket_summary)
    my_tickets_navigation(selection)
end

def main_menu_navigation(selection)
    if selection == "Search events"
        search_menu
    elsif selection == "View my tickets"
        ticket_summary = User.first.ticket_summary
        my_tickets_menu(ticket_summary)
    elsif selection == "Log out"
        exit
    else
        return "ERROR"
    end
end

def my_tickets_navigation(selection)
    # Given a selection from my_tickets_menu, return a summary of that event
    #Example selection (string): Opening Party - London
    event_name = selection.split(" - ")[0]
    event_city = selection.split(" - ")[1]
    location_id = Location.find_by(city: event_city).id
    event = Event.find_by(name: event_name, location_id: location_id )
    event.event_summary
    event_summary_navigation
end

def event_summary_menu
    $prompt.select("Actions:", ["Return to My Tickets", "Main Menu"])
end

def event_summary_navigation
    selection = event_summary_menu
    if selection == "Return to My Tickets"
        ticket_summary = User.first.ticket_summary
        my_tickets_menu(ticket_summary)
    elsif selection == "Main Menu"
        main_menu
    else
        "That is not a valid input!"
    end

end
