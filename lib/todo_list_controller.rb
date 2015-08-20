#!/usr/bin/env ruby

require './lib/todo_list.rb'
require './lib/task.rb'
require 'json'
require 'pry'

class TodoListController

	attr_accessor :todo_list, :tasks,:title, :priority, :complete

	def initialize
		self.todo_list = TodoList.new
		@task = Task.new(title, priority)
	end

	def list
		puts "\n\n"
		puts "Listing tasks:"
		puts "----------------------------------------------------------------------------------------------"
	    self.todo_list.tasks.each_with_index do |task, i|
	    	puts "#{i+1} #{task.to_s} #{task.priority}"
	    end
	    puts "\n\n"
	end

	def save(args)
        args.each do |file|
        	@todo_list.update(file)
        	puts "\n\nFile Saved\n\n"
       	end 
	end

	def load(args)
		args.each do |file|
			File.open(file)
		end
	end

	def complete(tasks)
        @task.complete
	end

	def add(args)
		@todo_list.add(Task.new(args.join('')))
	end
    

	def run
		command = nil
		print "Please enter commmand: "
		while command != 'exit'
			command = gets.chomp
			
			case command
		    when 'list'
		    	@list
    		when 'add'
    			self.add(args)
    		when 'load'
    			load(args)
    		when 'complete'
    			complete(args)
    		when 'exit'
    			puts "Exiting"
			else 
				puts "Command not found"
		    end
		end

	end


end

if __FILE__ == $0
	controller = TodoListController.new
	controller.run
end
