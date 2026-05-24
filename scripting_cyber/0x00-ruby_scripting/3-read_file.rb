require 'json'

def count_user_ids(path)
  # Read and parse the JSON file
  file_content = File.read(path)
  data = JSON.parse(file_content)

  # Create a hash with a default value of 0 to count user IDs
  id_counts = Hash.new(0)

  # Iterate through the array and increment the count for each userId
  data.each do |item|
    if item['userId']
      id_counts[item['userId']] += 1
    end
  end

  # Print the results in the requested format (userId: count)
  id_counts.each do |user_id, count|
    puts "#{user_id}: #{count}"
  end
rescue Errno::ENOENT
  puts "Error: File not found at #{path}"
rescue JSON::ParserError
  puts "Error: Failed to parse JSON file."
end
