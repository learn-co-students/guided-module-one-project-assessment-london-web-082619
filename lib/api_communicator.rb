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


#given a url AND TOKEN, returns data from the API - WORKING
def get_api_response(url)
    response_string = RestClient.get(url + $token)
    data = JSON.parse(response_string)
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

#given a city name (as a string), return all events in that city - WORKING
def find_events_by_city(city)
    events = get_api_response($city_search_url + city + "&expand=venue" + "&")
    return events["events"]
end

#given an event id, get the event city - WORKING
def get_event_city(event_id)
    url = "https://www.eventbriteapi.com/v3/events/" + event_id + "/?expand=venue"
    return get_api_response(url + "&")
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

#returns an array of event search results (to be passed into TTY Prompt function)
def display_search_results(results)
    events = []
    results.first(20).each do |event|
        date_formatted = display_date(parse_datetime(event["start"]))
        category_id = event["category_id"]
        events << "#{date_formatted}  |  #{event["name"]["text"]}  |  #{event["venue"]["address"]["city"]}  |  #{category_name(category_id)}"
    end
    events
end
     


binding.pry
'save'

#given a category, return all events for this category

# def get_event_data
#     get_api_response(event_search+token)
# end

# all_categories = get_api_response(categories+token)["categories"]

# def create_categories(all_categories)
#     all_categories.each do |category|
#         Category.create(name: category["name"], id: category["id"])
#     end
# end

# event_data_all = get_api_response(event_search+token)["events"][3]["name"]["text"]
# event_description = get_api_response(event_search+token)["events"][3]["description"]["text"]
# event_start = get_api_response(event_search+token)["events"][3]["start"]["text"]
# event_end = get_api_response(event_search+token)["events"][3]["end"]["text"]

# vancouver_events = get_api_response(event+token)

# venue_id = 
# category_id
# data3 = get_api_response(categories+token)
# events = data2["events"]


# def get_api_response(url)
#     response_string = RestClient.get(url)
#     JSON.parse(response_string)
# end

# RestClient::Request.execute method: :get, url: url, user: 'username', password: 'secret'

# event1 = {
#     "name"=> {"text"=>"ATLANTA'S NEWEST CLUB - REVEL OF WEST MIDTOWN  ", "html"=>"ATLANTA&#39;S NEWEST CLUB - REVEL OF WEST MIDTOWN  "},
#     "description"=> {"text"=>
#     "\n\n\nJoin Us This Saturday At The All New\n10 Million Dollar Venue - Revel of West Midtown Ladies  Free Till 12 W/RSVP Fellas Till 11:30\n\nText or Call 678.886.9542 Free Bday Parties Sections or More Info \n\n\nFollow @RevelAtlanta_ On Instagram\nFor All of Our Weekly Events \n\nPowered By @VonThePromoter \n\n",
#    "html"=>
#     "<P><BR></P>\n<P><BR></P>\n<P><STRONG><IMG SRC=\"https://cdn.evbuc.com/eventlogos/185561477/541642218cfe4655a0eaa32ecefba0d6.jpeg\"></STRONG></P>\n<P><STRONG>Join Us This Saturday At The All New</STRONG></P>\n<P><STRONG>10 Million Dollar Venue - Revel of West Midtown Ladies  Free Till 12 W/RSVP Fellas Till 11:30</STRONG><STRONG><BR></STRONG></P>\n<P><IMG SRC=\"https://cdn.evbuc.com/eventlogos/185561477/caea6cbd441a486684530980cef0ae26.jpeg\"></P>\n<P><STRONG>Text or Call 678.886.9542 Free Bday Parties Sections or More Info </STRONG></P>\n<P><BR></P>\n<P><STRONG><IMG SRC=\"https://cdn.evbuc.com/eventlogos/185561477/8d5e9ca38543413ba59ab218d5ebf08c.jpeg\"></STRONG></P>\n<P><STRONG>Follow @RevelAtlanta_ On Instagram</STRONG></P>\n<P><STRONG>For All of Our Weekly Events </STRONG></P>\n<P><BR></P>\n<P><STRONG>Powered By @VonThePromoter </STRONG></P>\n<P><BR></P>\n<P><BR></P>"},
#  "id"=>"34595163064",
#  "url"=>"https://www.eventbrite.com/e/atlantas-newest-club-revel-of-west-midtown-tickets-34595163064?aff=ebapi",
#  "start"=>{"timezone"=>"America/New_York", "local"=>"2019-09-14T22:00:00", "utc"=>"2019-09-15T02:00:00Z"},
#  "end"=>{"timezone"=>"America/New_York", "local"=>"2019-09-15T03:00:00", "utc"=>"2019-09-15T07:00:00Z"},
#  "organization_id"=>"186860407339",
#  "created"=>"2017-05-13T15:16:39Z",
#  "changed"=>"2019-09-09T14:29:20Z",
#  "published"=>"2017-05-13T15:17:27Z",
#  "capacity"=>nil,
#  "capacity_is_custom"=>nil,
#  "status"=>"live",
#  "currency"=>"USD",
#  "listed"=>true,
#  "shareable"=>true,
#  "online_event"=>false,
#  "tx_time_limit"=>480,
#  "hide_start_date"=>false,
#  "hide_end_date"=>false,
#  "locale"=>"en_US",
#  "is_locked"=>false,
#  "privacy_setting"=>"unlocked",
#  "is_series"=>false,
#  "is_series_parent"=>false,
#  "inventory_type"=>"limited",
#  "is_reserved_seating"=>false,
#  "show_pick_a_seat"=>false,
#  "show_seatmap_thumbnail"=>false,
#  "show_colors_in_seatmap_thumbnail"=>false,
#  "source"=>"create_2.0",
#  "is_free"=>true,
#  "version"=>"3.0.0",
#  "summary"=>"\n\n\nJoin Us This Saturday At The All New\n10 Million Dollar Venue - Revel of West Midtown Ladies  Free Till 12 W/RSVP Fellas Till 11:30\n<IMG S",
#  "logo_id"=>"64002825",
#  "organizer_id"=>"11385217525",
#  "venue_id"=>"37928631",
#  "category_id"=>"103",
#  "subcategory_id"=>"3008",
#  "format_id"=>"11",
#  "resource_uri"=>"https://www.eventbriteapi.com/v3/events/34595163064/",
#  "is_externally_ticketed"=>false,
#  "logo"=>
#   {"crop_mask"=>{"top_left"=>{"x"=>0, "y"=>128}, "width"=>960, "height"=>480},
#    "original"=>
#     {"url"=>"https://img.evbuc.com/https%3A%2F%2Fcdn.evbuc.com%2Fimages%2F64002825%2F186860407339%2F1%2Foriginal.20190617-122251?auto=compress&s=e57edf89dd8113f6ecd570574fbfb1a7", "width"=>960, "height"=>695},
#    "id"=>"64002825",
#    "url"=>"https://img.evbuc.com/https%3A%2F%2Fcdn.evbuc.com%2Fimages%2F64002825%2F186860407339%2F1%2Foriginal.20190617-122251?h=200&w=450&auto=compress&rect=0%2C128%2C960%2C480&s=aebd740eee274b7fb5fc60b4f1185637",
#    "aspect_ratio"=>"2",
#    "edge_color"=>"#797375",
#    "edge_color_set"=>true}}

#    [{"resource_uri"=>"https://www.eventbriteapi.com/v3/categories/103/", "id"=>"103", "name"=>"Music", "name_localized"=>"Music", "short_name"=>"Music", "short_name_localized"=>"Music"},
#     {"resource_uri"=>"https://www.eventbriteapi.com/v3/categories/101/",
#      "id"=>"101",
#      "name"=>"Business & Professional",
#      "name_localized"=>"Business & Professional",
#      "short_name"=>"Business",
#      "short_name_localized"=>"Business"},
#     {"resource_uri"=>"https://www.eventbriteapi.com/v3/categories/110/", "id"=>"110", "name"=>"Food & Drink", "name_localized"=>"Food & Drink", "short_name"=>"Food & Drink", "short_name_localized"=>"Food & Drink"},
#     {"resource_uri"=>"https://www.eventbriteapi.com/v3/categories/113/",
#      "id"=>"113",
#      "name"=>"Community & Culture",
#      "name_localized"=>"Community & Culture",
#      "short_name"=>"Community",
#      "short_name_localized"=>"Community"},
#     {"resource_uri"=>"https://www.eventbriteapi.com/v3/categories/105/",
#      "id"=>"105",
#      "name"=>"Performing & Visual Arts",
#      "name_localized"=>"Performing & Visual Arts",
#      "short_name"=>"Arts",
#      "short_name_localized"=>"Arts"}