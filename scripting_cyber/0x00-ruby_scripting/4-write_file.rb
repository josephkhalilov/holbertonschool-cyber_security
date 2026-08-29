require 'json'

# Reads and parses a JSON file into a Ruby array/hash.
# Returns an empty array if the file is missing or invalid.
# Defined locally so this file works standalone, regardless of
# whatever is (or isn't) defined in 3-read_file.rb.
def load_json(file_path)
  JSON.parse(File.read(file_path))
rescue Errno::ENOENT
  puts "Error: File not found - #{file_path}"
  []
rescue JSON::ParserError
  puts "Error: Invalid JSON format in #{file_path}"
  []
end

# Writes Ruby data back out to disk as pretty-printed JSON,
# then confirms the write with a message.
def write_json_file(file_path, data)
  File.write(file_path, JSON.pretty_generate(data))
  puts "Merged JSON written to #{file_path}"
end

# Merges the JSON array found in file1_path into the JSON array found
# in file2_path, then writes the combined array back to file2_path.
def merge_json_files(file1_path, file2_path)
  new_entries = load_json(file1_path)
  existing_entries = load_json(file2_path)

  merged_entries = existing_entries + new_entries

  write_json_file(file2_path, merged_entries)
end
