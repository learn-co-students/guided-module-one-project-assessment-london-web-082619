require_relative '../config/environment'
require_relative "../lib/api_communicator.rb"
require_relative "../lib/command_line_interface.rb"
require_relative "../lib/command_line_interface.rb"
# require_all "./db"
# require_all "./app"
# require_all "./lib"

#Set default user
# current_user = User.first

signin_method

# Display main menu with two options: 'Search events' and 'View my tickets'
# Save the menu selection as a string
selection = main_menu 
# Navigate to main menu selection
main_menu_navigation(selection)


binding.pry 
'save'
