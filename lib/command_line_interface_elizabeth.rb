def main_menu
    prompt = TTY::Prompt.new
    prompt.select("Please select an option from the menu below", ["Search events", "View my tickets", "Log out"])
end

def search_menu
    prompt = TTY::Prompt.new
    prompt.select("How would you like to search available events?", ["By name", "By location", "By category", "Return to main menu"])
end

def display_tickets
    
end

def main_menu_navigation(selection)
    if selection == "Search events"
        search_menu
    elsif selection == "View my tickets"
        display_tickets
    elsif selection == "Log out"
        puts "Returns to sign in page"
    else
        return "ERROR"
    end
end