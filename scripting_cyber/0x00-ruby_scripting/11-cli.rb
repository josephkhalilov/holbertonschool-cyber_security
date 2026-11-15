#!/usr/bin/env ruby
require 'optparse'

TASKS_FILE = 'tasks.txt'

def load_tasks
  File.exist?(TASKS_FILE) ? File.readlines(TASKS_FILE, chomp: true) : []
end

def save_tasks(tasks)
  File.write(TASKS_FILE, tasks.map { |t| "#{t}\n" }.join)
end

OptionParser.new do |opts|
  opts.banner = 'Usage: cli.rb [options]'

  opts.on('-a', '--add TASK', 'Add a new task') do |task|
    File.open(TASKS_FILE, 'a') { |f| f.puts(task) }
    puts "Task '#{task}' added."
  end

  opts.on('-l', '--list', 'List all tasks') do
    load_tasks.each_with_index { |task, i| puts "#{i + 1}. #{task}" }
  end

  opts.on('-r', '--remove INDEX', Integer, 'Remove a task by index') do |index|
    tasks = load_tasks
    if index.between?(1, tasks.size)
      removed = tasks.delete_at(index - 1)
      save_tasks(tasks)
      puts "Task '#{removed}' removed."
    else
      puts 'Invalid index.'
    end
  end

  opts.on('-h', '--help', 'Show help') do
    puts opts
    exit
  end
end.parse!
