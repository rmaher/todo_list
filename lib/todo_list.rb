#!/usr/bin/env ruby
require 'task'


class TodoList

	attr_accessor :tasks, :task

	def initialize
       self.tasks = []
	end

	def add(tasks)
       self.tasks << task
    end

end

if __FILE__ == $0

end
