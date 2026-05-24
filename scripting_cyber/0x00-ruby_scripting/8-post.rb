krequire 'net/http'
require 'uri'
require 'json'

def post_request(url, body_params = {})
  uri = URI.parse(url)

  # Create an HTTP POST request object
  request = Net::HTTP::Post.new(uri)
  
  # Set the content type to application/json
  request["Content-Type"] = "application/json"
  
  # Convert the hash parameters directly into a JSON string
  request.body = body_params.to_json

  # Execute the request inside the connection block
  response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: uri.scheme == 'https') do |http|
    http.request(request)
  end

  # Print the HTTP status code and message
  puts "Response status: #{response.code} #{response.message}"

  # Parse the response body string into a Ruby object and pretty-print it
  parsed_body = JSON.parse(response.body)
  puts "Response body:"
  puts JSON.pretty_generate(parsed_body)

rescue Errno::ECONNREFUSED, SocketError
  puts "Error: Failed to connect to the server."
rescue JSON::ParserError
  puts "Response body:"
  puts response.body
end
