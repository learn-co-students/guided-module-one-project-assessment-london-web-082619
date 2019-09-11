$prompt = TTY::Prompt.new 

def signin_method  #works
   user_input = $prompt.select("Welcome to EventBkr. Please enter your details to proceed with your booking", ["Log in", "Register"])
   if user_input == "Log in"
   log_in 
else 
   register 
   selection = main_menu 
end 

end 

def register 
   first_name = $prompt.ask("First Name:", required: true)
   last_name = $prompt.ask("Last Name:", required: true)
   email = $prompt.ask("Email:", required: true)
   password = $prompt.mask("Password:", required: true)
   user = User.create(first_name: first_name, last_name: last_name, email: email, password: password)
   $current_user = user
end 

def log_in_prompt #works
   email = $prompt.ask("Email:", required: true) {|q|
        q.validate(/\A\w+@\w+\.\w+\Z/, 'Invalid email address')}
   password = $prompt.mask("Password:", required: true)
   [email, password]
end 

def log_in #works
  array = log_in_prompt
  user1 = User.find_by(email: array[0])
  if user1.email == array[0] && user1.password == array[1]
      $current_user = user1

      puts "\nHere we go!\n"

      selection = main_menu 
   else #works
       i= 0
      until i == 3  
         puts "Invalid email and password. Please try again."
         array = log_in_prompt
         if user1.email == array[0] && user1.password == array[1]

             puts "\nHere we go!\n"

             selection = main_menu
         end
         i += 1
      end
   end
end 

def search
   searchmenu = $prompt.select("How would you like to refine your search?", ["Name", "Location", "Category"])
   case searchmenu 

#    when "Name" #works
#       name_input = $prompt.ask("Enter keywords to filter your search", required: true)
#       search_result = Event.names.select{|e| e.include?(name_input)}
#       results = $prompt.select("Results", search_result)
#       Event.find_by(name: results).event_summary
#       input = $prompt.select("Options", ["Make Booking", "Main Menu"])

#          if input == "Make Booking"
#       num = $prompt.ask("Quantity:")
#       puts "Congratulations! You have secured a booking of #{num} tickets!"
#       result_object = Event.find_by(name: results)
#       new_ticket = Booking.new(user_id: $current_user.id, event_id: result_object.id, number: num.to_i) 
#       main_menu
#          else  
#         main_menu 
#          end 
   
   when "Location"
    cities = ["London", "Manchester", "Liverpool", "Edinburgh", "Oxford", "Brighton", "Birmingham", "Glasgow", "Cambridge", "Belfast", "Dublin", "Leeds", "Bath"].sort
    #requests user to select a city  
    location_input = $prompt.select("Select Location(s)", cities, filter: true)
    #given selection, returns event data for that city
    results = find_events_by_city(location_input)  #location object
    #displays random 20 events for that city as a menu
    choice = $prompt.select("Event(s) at this location", display_search_results(results), filter: true)
    #displays more details about the selected event
    event_data = event_summary(choice) #Broken - still needs fixing
    input = $prompt.select("Options", ["Make Booking", "Main Menu"])
    if input == "Make Booking"
        num = $prompt.ask("Quantity:", required: true) #NEED TO ADD VALIDATION
        #find the event data from the API
        #create an Event Object using the data from the API
        new_event = create_event_object(event_data)
        #create a booking using the newly created event object and num of tickets input
        new_ticket = Booking.new(user_id: $current_user.id, event_id: new_event.id, number: num.to_i) 
        puts "\nCongratulations! You have secured a booking of #{num} tickets!\n"
        main_menu
    else  
        main_menu 
    end 

    when "Category"
        category_selection = $prompt.select("Select Categories", get_categories, filter: true)
        results = find_events_by_category(category_selection)
        choice = $prompt.select("Event(s) with this category", display_search_results(results), filter: true)
        event_data = event_summary(choice) #Broken - still needs fixing
        input = $prompt.select("Options", ["Make Booking", "Main Menu"])
    if input == "Make Booking"
        num = $prompt.ask("Quantity:", required: true) #NEED TO ADD VALIDATION
        #find the event data from the API
        #create an Event Object using the data from the API
        new_event = create_event_object(event_data)
        #create a booking using the newly created event object and num of tickets input
        new_ticket = Booking.new(user_id: $current_user.id, event_id: new_event.id, number: num.to_i) 

        puts "\nCongratulations! You have secured a booking of #{num} tickets!\n"
        main_menu
    else  
        main_menu 
    end 
   end
end

def no_bookings 
    puts "\nYou have no bookings\n\n"
    selection = $prompt.select("What would you like to next?", ["Search For More Events", "Log Out", "End Session"])
    case selection 
    when "Search For More Events"
        search 
    when "Log Out" 
        signin_method 
    when "End Session"
        exit 
    end
end 

def main_menu
    selection = $prompt.select("Please select an option from the menu below", ["Search Events", "View My Bookings", "Log Out", "End Session"])
    case selection 
    when "Search Events" #works
        search
    when "View My Bookings" #work
        $booking_summary = $current_user.booking_summary #in array
        if $book_summary.nil?
            no_bookings
        else 
            my_bookings_navigation($booking_summary)
        end 
    when "Log Out" #works
        signin_method
    when "End Session"
        exit
    end
end


def my_bookings_navigation(booking_summary) #works
    selection = $prompt.select("You currently have #{$current_user.bookings.length} event ticket(s). Please click on a ticket to see more about that event.", booking_summary)
    # Given a selection from my_tickets_menu, return a summary of that event
    #Example selection (string): Opening Party - London
    event_name = selection.split(" - ")[0]
    event_city = selection.split(" - ")[1]
    location_id = Location.find_by(city: event_city).id
    event = Event.find_by(name: event_name, location_id: location_id)
    event.event_summary
    event_summary_navigation
end

def event_summary_menu #works
    $prompt.select("Actions:", ["Modify My Bookings", "Main Menu"])
end

def event_summary_navigation

    selection = event_summary_menu

   #  if selection == "View My Bookings"
   #    binding.pry
   #      booking_summary = $current_user.booking_summary #booking_summary gives an array
   #    #   my_bookings_menu(booking_summary)

   if selection == "Modify My Bookings"
        input = $prompt.select("Which booking would you like to change?", $booking_summary) #works
        action = $prompt.select("Actions: ", ["Change Quantity", "Refund Bookings"]) #works

        case action 

        when "Change Quantity"
            event_name = $booking_summary.join.split(" - ")[0]
            new_num = $prompt.ask("Updated Total Number of Tickets You Wish to Book for This Event: ") #works
            selected_event = Event.find_by(name: event_name)
            Booking.update(user_id: $current_user.id, event_id: selected_event.id, number: new_num)

            puts "\nUpdated!\n"

            main_menu

        when "Refund Bookings"
            Booking.where("user_id = ?", $current_user.id).destroy_all #check

            puts "\nYou have no bookings.\n" #works

            main_menu
        end 

   else #selection == "Main Menu"
        main_menu
    end

end
