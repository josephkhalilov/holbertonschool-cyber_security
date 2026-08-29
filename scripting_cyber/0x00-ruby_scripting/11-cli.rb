#!/usr/bin/env ruby

require 'optparse'

TASKS_FILE = 'tasks.txt'

def load_tasks
  return [] unless File.exist?(TASKS_FILE)

  File.readlines(TASKS_FILE).map(&:chomp)
end

def save_tasks(tasks)
  File.write(TASKS_FILE, tasks.map { |task| "#{task}\n" }.join)
end

def add_task(task)
  tasks = load_tasks
  tasks << task
  save_tasks(tasks)
  puts "Task '#{task}' added."
end

def list_tasks
  tasks = load_tasks
  tasks.each_with_index do |task, index|
    puts "#{index + 1}. #{task}"
  end
end

def remove_task(index)
  tasks = load_tasks
  position = index - 1

  if position >= 0 && position < tasks.length
    removed = tasks.delete_at(position)
    save_tasks(tasks)
    puts "Task '#{removed}' removed."
  else
    puts 'Invalid task index.'
  end
end

options = {}

OptionParser.new do |opts|
  opts.banner = 'Usage: cli.rb [options]'

  opts.on('-a', '--add TASK', 'Add a new task') do |task|
    options[:add] = task
  end

  opts.on('-l', '--list', 'List all tasks') do
    options[:list] = true
  end

  opts.on('-r', '--remove INDEX', Integer, 'Remove a task by index') do |index|
    options[:remove] = index
  end

  opts.on('-h', '--help', 'Show help') do
    puts opts
    exit
  end
end.parse!

if options[:add]
  add_task(options[:add])
elsif options[:list]
  list_tasks
elsif options[:remove]
  remove_task(options[:remove])
end
