require 'json'

# Reads and parses a JSON file into a Ruby array/hash.
# Returns an empty array if the file is missing or invalid.
def read_json_file(file_path)
  JSON.parse(File.read(file_path))
rescue Errno::ENOENT
  puts "Error: File not found - #{file_path}"
  []
rescue JSON::ParserError
  puts "Error: Invalid JSON format in #{file_path}"
  []
end

# Reads a JSON file of objects containing a "userId" field and
# prints how many entries exist per userId, sorted by userId.
def count_user_ids(file_path)
  data = read_json_file(file_path)
  counts = Hash.new(0)

  data.each do |entry|
    user_id = entry['userId']
    counts[user_id] += 1 if user_id
  end

  counts.sort.each do |user_id, count|
    puts "#{user_id}: #{count}"
  end
end
