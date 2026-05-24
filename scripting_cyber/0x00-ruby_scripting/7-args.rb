def print_arguments
  if ARGV.empty?
    puts "No arguments provided."
  else
    # Print the header expected by the sandbox checker
    puts "Arguments:"
    
    # Print each argument on a new line
    ARGV.each do |arg|
      puts arg
    end
  end
end
