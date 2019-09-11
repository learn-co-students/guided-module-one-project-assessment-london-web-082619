# API Key: GZTRKQGFPJKEIBOTGG
# Client secret: 22IUR3M6DVO7PXJSPQTT7F2FCLGX5QTLLJP2ODNORXDVOSLYRV
# Private token: CXS22JWMRNKAGSTG6RXF
# Public token: 6LBP7OZ37SMBHZCM75LS
# require_relative "../lib/command_line_start.rb"

require 'rest-client'
require 'json'
require 'pry'

$token = "token=CXS22JWMRNKAGSTG6RXF"
#if URL is one => /?
#if URL is two => &

#EVENTBRITE API URLs
$event_search_url = "https://www.eventbriteapi.com/v3/events/search"
$categories_url = "https://www.eventbriteapi.com/v3/categories"
$category_search_url = "https://www.eventbriteapi.com/v3/events/search/?categories="#+add category ID
$city_search_url = "https://www.eventbriteapi.com/v3/events/search?location.address="#add city name
event_di_search = "https://www.eventbriteapi.com/v3/events/{event_id}/?expand=venue"


#given a url AND TOKEN, returns data from the API - WORKING
def get_api_response(url)
    response_string = RestClient.get(url + $token)
    data = JSON.parse(response_string)
end

#returns an array of all event data
def get_all_event_info
    get_api_response($event_search_url + "/?expand=venue" "&")["events"]
end

#return an array of categories - WORKING
def get_categories
    all_category_info = get_api_response($categories_url + "/?")["categories"]
    categories = []
    all_category_info.each{ |category| categories << category["name"] }
    categories.sort
end

#returns category name given a category ID - WORKING
def category_name(category_id)
    if category_instance = get_api_response($categories_url + "/?")["categories"].find{ |c| c["id"] == category_id }
        return category_instance["name"]
    else
        return "Uncategorised"
    end
end

#given category name, return category ID number - WORKING
def get_category_id(category_name)
    all_category_info = get_api_response($categories_url + "/?")["categories"]
    category = all_category_info.find{ |category| category["name"] == category_name }
    return category["id"]
end

#given a category name, get all events with that category ID - WORKING
def find_events_by_category(category_name)
    category_id = get_category_id(category_name)
    response = get_api_response($category_search_url + category_id + "&expand=venue" + "&")["events"] #returns array of hashes where eash hash contains info for a specific events
end

#given an event id, get the event city - WORKING
def get_event_city(event_id)
    url = "https://www.eventbriteapi.com/v3/events/" + event_id + "/?expand=venue"
    return get_api_response(url + "&")
end

#given a city name (as a string), return all events in that city - WORKING
def find_events_by_city(city)
    events = get_api_response($city_search_url + city + "&expand=venue" + "&")
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
    results.sample(20).each do |event|
        date_formatted = display_date(parse_datetime(event["start"]))
        category_id = event["category_id"]
        events << "#{event["id"]}  |  #{date_formatted}  |  #{event["name"]["text"]}  |  #{event["venue"]["address"]["city"]}  |  #{category_name(category_id)}"
    end
    events
end
  
s1 = "53667810867  |  September 13 2019 - 22:00  |  Suite Life Fridays Hosted by Big Tigger and Friends Friday at Suite Lounge  |  Atlanta  |  Music"
s2 = "70388551051  |  October 6 2019 - 12:00  |  Hop City's Lucky 7th Anniversary  |  Birmingham  |  Uncategorised"
s3 = "62514061240  |  October 23 2019 - 7:00  |  Alabama Literacy Association 51st Annual Conference  |  Birmingham  |  Family & Education"
test_events = find_events_by_city("Birmingham")
display = display_search_results(test_events)

#given the selection from the search results, finds the event info and displays it in a summary - WORKING
def event_summary(selection)
    event_id = selection.split("  |  ")[0]
    event_data = get_api_response("https://www.eventbriteapi.com/v3/events/" + event_id + "/?expand=venue" + "&")
    #print out event data
    puts "Event Name: #{event_data["name"]["text"]}"
    puts "Date & Time: #{display_date(parse_datetime(event_data["start"]))}"
    puts "Location: #{event_data["venue"]["address"]["city"]}"
    puts "Category: #{category_name(event_data["category_id"])}"
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
    category = category_name(event_data["category_id"])
    new_event = Event.create(name: name, description: description, start_time: start_time, end_time: end_time, location: location, category: category)
    new_event
end

#SEARCH BY NAME

# binding.pry
# 'save'
