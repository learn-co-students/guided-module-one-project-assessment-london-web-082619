$prompt = TTY::Prompt.new 

def signin_method 
   user_input = $prompt.select("Welcome to EventBkr. Please enter your details to proceed with your booking", ["Log in", "Register"])
   if user_input == "Log in"
   log_in 
else 
   register 
   selection = main_menu 
   main_menu_navigation(selection)
end 

end 

def register 
   first_name = $prompt.ask("First Name:", required: true)
   last_name = $prompt.ask("Last Name:", required: true)
   email = $prompt.ask("Email:", required: true)
   password = $prompt.mask("Password:", required: true)
   user = User.create(first_name: first_name, last_name: last_name, email: email, password: password)
end 

def log_in_prompt
   email = $prompt.ask("Email:", required: true)
   password = $prompt.mask("Password:", required: true)
   [email, password]
end 


def log_in 
  array = log_in_prompt
   if User.user_emails.include?(array[0]) && User.user_passwords.include?(array[1])
      puts "Lets see whats happening today!"
      selection = main_menu 
      main_menu_navigation(selection)
   else 
       i= 0
      until i == 3  
         puts "Invalid email and password. Please try again."
         array = log_in_prompt
         if User.user_emails.include?(array[0]) && User.user_passwords.include?(array[1])
             puts "Lets see whats happening today!"
             selection = main_menu
         end
         i += 1
      end
   end
end 

def mainmenu
   input = $prompt.select("What would like you to do next?", ["Book Ticket", "Main Menu", "Search For More Events", "End Session"])
   case input 
   when "Book Ticket"
      puts "Congratulations! You have secured a booking!"
      Ticket.create
       second_input = $prompt.select("What would like you to do next?", ["Main Menu", "Search For More Events", "End Session"])
      case second_input 
         when "Main Menu"
      main_menu
         when "Search For More Events"
      search
         when "End Session"
            return
         end 
   when "Main Menu"
      main_menu
   when "Search For More Events"
      search
   when "End Session"
      return
   end 
end 

def search
   searchmenu = $prompt.select("How would you like to refine your search?", ["Name", "Location", "Category"])
case searchmenu 

   when "Name"
      name_input = $prompt.ask("Enter keywords to filter your search")
      search_result = Event.names.select{|e| e.include?(name_input)}
      results = $prompt.select("Results", search_result)
      Event.find_by(name: results).event_summary
      mainmenu

   when "Location"
      location_input = $prompt.select("Select Location(s)", Location.cities, filter: true)
      results = Location.find_by(city: location_input)  #location object
      event_names = results.events.map{|event| event.name}
      choice = $prompt.select("Event(s) at this location", event_names, filter: true)
      Event.find_by(name: choice).event_summary
      mainmenu

   when "Category"
      category_input = $prompt.select("Select Categories", Category.names, filter: true)
      results = Category.find_by(name: category_input)
      event_names = results.events.map{|event| event.name}
      choice = $prompt.select("Event(s) with this category", event_names, filter: true)
      Event.find_by(name: choice).event_summary
      mainmenu

   end
end
