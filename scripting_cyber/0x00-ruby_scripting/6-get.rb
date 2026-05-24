require 'net/http'
require 'uri'
require 'json'

def get_request(url)
  # Parse the string URL into a URI object
  uri = URI.parse(url)

  # Perform the HTTP GET request
  response = Net::HTTP.get_response(uri)

  # Print the HTTP status code and message (e.g., "200 OK")
  puts "Response status: #{response.code} #{response.message}"

  # Parse the response body string into a Ruby object and pretty-print it
  parsed_body = JSON.parse(response.body)
  puts "Response body:"
  puts JSON.pretty_generate(parsed_body)

rescue Errno::ECONNREFUSED, SocketError
  puts "Error: Failed to connect to the server."
rescue JSON::ParserError
  # Fallback in case the response body isn't valid JSON
  puts "Response body:"
  puts response.body
end
