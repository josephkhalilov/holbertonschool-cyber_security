require 'open-uri'
require 'uri'
require 'fileutils'

# 1. Validate that exactly 2 arguments are provided
if ARGV.length != 2
  puts "Usage: 9-download_file.rb URL LOCAL_FILE_PATH"
  exit 1
end

url = ARGV[0]
local_path = ARGV[1]

begin
  # 2. Print the initial downloading message
  puts "Downloading file from #{url}..."

  # 3. Download the content using open-uri
  URI.open(url) do |remote_file|
    # Ensure the target local directory structure exists
    dir = File.dirname(local_path)
    FileUtils.mkdir_p(dir) unless Dir.exist?(dir)

    # Write the remote stream chunk down into the file path
    File.open(local_path, 'wb') do |local_file|
      local_file.write(remote_file.read)
    end
  end

  # 4. Print the final success message
  puts "File downloaded and saved to #{local_path}."

rescue SocketError, Errno::ECONNREFUSED
  puts "Error: Failed to connect to the server or invalid URL."
rescue OpenURI::HTTPError => e
  puts "Error: Server returned an HTTP Error - #{e.message}"
rescue => e
  puts "An unexpected error occurred: #{e.message}"
end
