require_relative '3-read_file'
require 'json'

# Writes Ruby data back out to disk as pretty-printed JSON.
def write_json_file(file_path, data)
  File.write(file_path, JSON.pretty_generate(data))
end

# Merges the JSON array found in file1_path into the JSON array found
# in file2_path, then writes the combined array back to file2_path.
def merge_json_files(file1_path, file2_path)
  new_entries = read_json_file(file1_path)
  existing_entries = read_json_file(file2_path)

  merged_entries = existing_entries + new_entries

  write_json_file(file2_path, merged_entries)
end
