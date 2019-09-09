# API Key: GZTRKQGFPJKEIBOTGG
# Client secret: 22IUR3M6DVO7PXJSPQTT7F2FCLGX5QTLLJP2ODNORXDVOSLYRV
# Private token: CXS22JWMRNKAGSTG6RXF
# Public token: 6LBP7OZ37SMBHZCM75LS

require 'rest-client'
require 'json'
require 'pry'
# require 'net/http'

# data = RestClient.get("https://www.eventbriteapi.com/v3/users/me", headers = {Authorization: Bearer "CXS22JWMRNKAGSTG6RXF"} )

event_search = "https://www.eventbriteapi.com/v3/events/search"
categories = "https://www.eventbriteapi.com/v3/categories"
token = "/?token=CXS22JWMRNKAGSTG6RXF"
user = "https://www.eventbriteapi.com/v3/users/me"
event = "https://www.eventbriteapi.com/v3/events/search?location.address=vancovuer&location.within=10km&expand=venue"

def get_api_response(url)
    response_string = RestClient.get(url)
    data = JSON.padatarse(response_string)
end

data = get_api_response(user+token)
data2 = get_api_response(event_search+token)
data3 = get_api_response(categories+token)
# events = data2["events"]

# binding.pry
# 'save'
# def get_api_response(url)
#     response_string = RestClient.get(url)
#     JSON.parse(response_string)
# end

# RestClient::Request.execute method: :get, url: url, user: 'username', password: 'secret'

