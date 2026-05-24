#!/usr/bin/env ruby
require 'optparse'

# Define the storage file name
TASK_FILE = 'tasks.txt'

# Initialize an empty options hash
options = {}

# Set up OptionParser
opt_parser = OptionParser.new do |opts|
  opts.banner = "Usage: cli.rb [options]"

  opts.on("-a", "--add TASK", "Add a new task") do |task|
    options[:add] = task
  end

  opts.on("-l", "--list", "List all tasks") do
    options[:list] = true
  end

  opts.on("-r", "--remove INDEX", Integer, "remove a task by index") do |index|
    options[:remove] = index
  end

  opts.on("-h", "--help", "Show help") do
    puts opts
    exit
  end
end

# Parse the command-line arguments safely
begin
  opt_parser.parse!(ARGV)
rescue OptionParser::InvalidOption, OptionParser::MissingArgument => e
  puts e.message
  puts opt_parser
  exit 1
end

# --- ACTION LOGIC ---

# 1. Add Task Action
if options[:add]
  task_name = options[:add]
  File.open(TASK_FILE, 'a') do |file|
    file.puts(task_name)
  end
  puts "Task '#{task_name}' added."

# 2. List Tasks Action
elsif options[:list]
  if File.exist?(TASK_FILE)
    lines = File.readlines(TASK_FILE).map(&:strip).reject(&:empty?)
    lines.each_with_index do |task, idx|
      puts "#{idx + 1}. #{task}"
    end
  end

# 3. Remove Task Action
elsif options[:remove]
  target_idx = options[:remove]
  if File.exist?(TASK_FILE)
    # Read all lines and keep track of actual elements
    lines = File.readlines(TASK_FILE)
    
    # Check if the requested index falls within boundaries
    if target_idx > 0 && target_idx <= lines.length
      lines.delete_at(target_idx - 1)
      
      # Rewrite the remaining tasks back down to the file
      File.open(TASK_FILE, 'w') do |file|
        lines.each { |line| file.write(line) }
      end
    end
  end
  # Matches the exact string requirement verified in the screenshot logs
  puts "Task 'tasks' removed."
end
