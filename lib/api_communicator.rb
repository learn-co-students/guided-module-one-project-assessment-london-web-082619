# API Key: GZTRKQGFPJKEIBOTGG
# Client secret: 22IUR3M6DVO7PXJSPQTT7F2FCLGX5QTLLJP2ODNORXDVOSLYRV
# Private token: CXS22JWMRNKAGSTG6RXF
# Public token: 6LBP7OZ37SMBHZCM75LS
# require_relative "../lib/command_line_start.rb"

class EventBrite

    require 'rest-client'
    require 'json'
    require 'pry'

    @@token = "token=CXS22JWMRNKAGSTG6RXF"
    #if URL is one => /?
    #if URL is two => &
    
    #EVENTBRITE API URLs
    @@event_search_url = "https://www.eventbriteapi.com/v3/events/search"
    @@all_categories_url = "https://www.eventbriteapi.com/v3/categories"
    @@search_by_category_url = "https://www.eventbriteapi.com/v3/events/search/?categories=" # append category_id
    @@search_by_location_url = "https://www.eventbriteapi.com/v3/events/search?location.address=" # append city name
    @@event_search = "https://www.eventbriteapi.com/v3/events/" #append event_id + /?expand=venue"
    
    #given a url AND TOKEN, returns data from the API - WORKING
    def self.get_api_response(url)
        response_string = RestClient.get(url + @@token)
        JSON.parse(response_string)
    end

    #returns an array of all category info
    def self.all_categories
        get_api_response(@@all_categories_url + "/?")["categories"]
    end

    #returns a sorted array of categories - WORKING
    def self.get_categories
        self.all_categories.map{ |category| category["name"] }.sort
    end
    
    #given a category_id, returns the category name
    def self.category_name(category_id)
        category_data = self.all_categories.find{ |category| category["id"] == category_id } ? category_data["name"] : "Uncategorised"
    end
    
    #given category name, return category ID number - WORKING
    def self.get_category_id(category_name)
        category_id = self.all_categories.find{ |category| category["name"] == category_name }["id"] ? category_id : "Uncategorised"
    end
    
    #given a category name, get all events with that category ID - WORKING
    def self.find_events_by_category(category_name)
        self.get_api_response(@@search_by_category_url + self.get_category_id(category_name) + "&expand=venue" + "&")["events"] #returns array of hashes where eash hash contains info a specific events
    end
    
    #given an event id, get the event city - WORKING
    def get_event_city(event_id)
        url = "https://www.eventbriteapi.com/v3/events/" + event_id + "/?expand=venue"
        return self.get_api_response(url + "&")
    end
    
    #given a city name (as a string), return all events in that city - WORKING
    def find_events_by_city(city)
        events = self.get_api_response(@@search_by_location_url + city + "&expand=venue" + "&")
        return events["events"]
    end
    
    #parses the fate format used in EventBrite API to format used in Active Record - WORKING
    def parse_datetime(datetime_hash)
        datetime = datetime_hash["local"].split("-")
        year = datetime[0]
        month = datetime[1]
        day = datetime[2].split("T")[0]
        hour = datetime[2].split("T")[1].split(":")[0]
        minute = datetime[2].split("T")[1].split(":")[1]
        # return "#{year}, #{month}, #{day}, #{hour}, #{minute}"
        Time.new(year, month, day, hour, minute)
    end
    
    #given a datetime formatted for ActiveRecord, returns the month name for a given month - WORKING
    def return_month_as_string(datetime)
        case datetime.month
        when 1
            "January"
        when 2
            "February"
        when 3
            "March"
        when 4
            "April"
        when 5
            "May"
        when 6
            "June"
        when 7
            "July"
        when 8
            "August"
        when 9
            "September"
        when 10
            "October"
        when 11
            "November"
        when 12
            "December"
        else
            "This isn't a valid month!"
        end
    end
    
    
    #given a date, returns a readable string - WORKING
    def display_date(datetime)
        "#{return_month_as_string(datetime)} #{datetime.day} #{datetime.year} - #{datetime.hour}:00"
    end
    
    #returns an array of event search results (to be passed into TTY Prompt function)- WORKING
    def display_search_results(results)
        events = []
        show = 0
        if results.length > 20
            show = 20
        else
            show = results.length
        end
        events_to_display = results.sample(show)
        events_to_display.each do |event|
            event_id = event["id"]
            if date_formatted = display_date(parse_datetime(event["start"])) 
                date_formatted
            else
                date_formatted = display_date(Time.now)
            end
            if event_name = event["name"]["text"]
                event_name
            else 
                event_name = "Un-named"
            end
            if location = event["venue"]["address"]["city"]
                location 
            else
                location = "Not specified"
            end
            if category = self.category_name(event["category_id"])
                category
            else
                category = "Not specified"
            end
            events << "#{event_id}  |  #{date_formatted}  |  #{event_name}  |  #{location}  |  #{category}"
        end
        events
    end
    
    #given the selection from the search results, finds the event info and displays it in a summary - WORKING
    def event_summary(selection)
        event_id = selection.split("  |  ")[0]
        event_data = self.get_api_response("https://www.eventbriteapi.com/v3/events/" + event_id + "/?expand=venue" + "&")
        #print out event data
        puts "Event Name: #{event_data["name"]["text"]}"
        puts "Date & Time: #{display_date(parse_datetime(event_data["start"]))}"
        puts "Location: #{event_data["venue"]["address"]["city"]}"
        puts "Category: #{self.category_name(event_data["category_id"])}"
        puts "Description: #{event_data["description"]["text"]}"
        event_data
    end
    
    #given a hash of event data from EventBrite, create an instance of event in ActiveRecord - WORKING
    def create_event_object(event_data)
        name = event_data["name"]["text"]
        description = event_data["description"]["text"]
        start_time = parse_datetime(event_data["start"])
        end_time = parse_datetime(event_data["end"])
        location = event_data["venue"]["address"]["city"]
        category = self.category_name(event_data["category_id"])
        new_event = Event.create(name: name, description: description, start_time: start_time, end_time: end_time, location: location, category: category)
        new_event
    end
    
    #SEARCH BY NAME
    
    binding.pry
    'save'
    


end
