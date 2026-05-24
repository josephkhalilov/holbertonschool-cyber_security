def print_arguments
  # Check if the global ARGV array is empty
  if ARGV.empty?
    puts "No arguments provided."
  else
    # Loop through arguments with their index, starting the count at 1
    ARGV.each_with_index do |arg, index|
      puts "#{index + 1}. #{arg}"
    end
  end
end
