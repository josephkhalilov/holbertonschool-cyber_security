require 'net/http'
require 'uri'
require 'json'

def post_request(url, body_params = {})
  # Parse the string URL into a URI object
  uri = URI.parse(url)

  # Create an HTTP POST request object
  request = Net::HTTP::Post.new(uri)
  
  # Set the form data using the body parameters hash
  request.set_form_data(body_params)

  # Execute the request inside a block that manages the connection safely
  response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: uri.scheme == 'https') do |http|
    http.request(request)
  end

  # Print the HTTP status code and message (e.g., "201 Created")
  puts "Response status: #{response.code} #{response.message}"

  # Parse the response body string into a Ruby object and pretty-print it
  parsed_body = JSON.parse(response.body)
  puts "Response body:"
  puts JSON.pretty_generate(parsed_body)

rescue Errno::ECONNREFUSED, SocketError
  puts "Error: Failed to connect to the server."
rescue JSON::ParserError
  # Fallback if the server response is not in JSON format
  puts "Response body:"
  puts response.body
end
