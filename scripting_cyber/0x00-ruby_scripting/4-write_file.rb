require 'json'

def merge_json_files(file1_path, file2_path)
  # 1. Read and parse the first JSON file
  file1_content = File.read(file1_path)
  data1 = JSON.parse(file1_content)

  # 2. Read and parse the second JSON file
  file2_content = File.read(file2_path)
  data2 = JSON.parse(file2_content)

  # Ensure both files contain arrays before merging
  if data1.is_a?(Array) && data2.is_a?(Array)
    # 3. Merge data1 into data2
    merged_data = data2 + data1
  else
    # Fallback if the files contain single JSON objects instead of arrays
    merged_data = [data2, data1].flatten
  end

  # 4. Write the pretty-printed merged data back to file2_path
  File.open(file2_path, 'w') do |f|
    f.write(JSON.pretty_generate(merged_data))
  end
rescue Errno::ENOENT => e
  puts "Error: File not found - #{e.message}"
rescue JSON::ParserError
  puts "Error: Failed to parse one of the JSON files."
end
