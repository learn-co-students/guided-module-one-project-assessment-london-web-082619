# API Key: GZTRKQGFPJKEIBOTGG
# Client secret: 22IUR3M6DVO7PXJSPQTT7F2FCLGX5QTLLJP2ODNORXDVOSLYRV
# Private token: CXS22JWMRNKAGSTG6RXF
# Public token: 6LBP7OZ37SMBHZCM75LS

require 'rest-client'
require 'json'
require 'pry'
# require 'net/http'

# data = RestClient.get("https://www.eventbriteapi.com/v3/users/me", headers = {Authorization: Bearer "CXS22JWMRNKAGSTG6RXF"} )

response_string = RestClient.get("https://www.eventbriteapi.com/v3/users/me/?token=CXS22JWMRNKAGSTG6RXF")
data = JSON.parse(response_string)

binding.pry
'save'
# def get_api_response(url)
#     response_string = RestClient.get(url)
#     JSON.parse(response_string)
# end

# RestClient::Request.execute method: :get, url: url, user: 'username', password: 'secret'

