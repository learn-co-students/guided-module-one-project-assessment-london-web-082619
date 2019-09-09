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

def log_in 
   email = $prompt.ask("Email:", required: true)
   password = $prompt.mask("Password:", required: true)
   
   if User.user_emails.include?(email) && User.user_passwords.include?(password)
      puts "Lets see whats happening today!"
      selection = main_menu 
      main_menu_navigation(selection)
   else 
      i= 0
      j = 3
      until i < j do 
      puts "Invalid email and password. Please try again."
    User.user_emails.include?(email) && User.user_passwords.include?(password)
   log_in 
      end 
   end 
end 