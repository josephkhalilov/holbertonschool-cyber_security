require 'digest'

# 1. Validate that exactly 2 arguments are provided
if ARGV.length != 2
  puts "Usage: 10-password_cracked.rb HASHED_PASSWORD DICTIONARY_FILE"
  exit 1
end

target_hash = ARGV[0].downcase.strip
dictionary_path = ARGV[1]

# Check if the dictionary file exists before opening
unless File.exist?(dictionary_path)
  puts "Error: Dictionary file not found at #{dictionary_path}"
  exit 1
end

password_found = false

# 2. Open and read the dictionary file line by line
File.open(dictionary_path, "r").each_line do |line|
  # Strip trailing newlines or spaces from the dictionary word
  word = line.strip
  next if word.empty?

  # 3. Hash the word using SHA-256
  current_hash = Digest::SHA256.hexdigest(word)

  # 4. Compare hashes
  if current_hash == target_hash
    puts "Password found: #{word}"
    password_found = true
    break
  end
end

# 5. Fallback if no words matched
puts "Password not found in dictionary." unless password_found
