require 'digest'

def usage
  puts 'Usage: 10-password_cracked.rb HASHED_PASSWORD DICTIONARY_FILE'
  exit
end

def crack_password(hashed_password, dictionary_file)
  File.foreach(dictionary_file) do |line|
    word = line.chomp
    if Digest::SHA256.hexdigest(word) == hashed_password
      puts "Password found: #{word}"
      return
    end
  end
  puts 'Password not found in dictionary.'
end

usage if ARGV.length != 2

hashed_password = ARGV[0]
dictionary_file = ARGV[1]

crack_password(hashed_password, dictionary_file)
