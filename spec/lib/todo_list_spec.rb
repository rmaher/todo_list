require "spec_helper"
require "json"

describe TodoList do
	let(:todo_list){ TodoList.new }

	before do
		todo_list.add(Task.new("Pay bills", 1))
		todo_list.add(Task.new("Buy milk", 2))
	end

	it "stores tasks" do
		expect(todo_list.tasks.map(&:title)).to include("Pay bills", "Buy milk")
	end

	describe "#save" do

		it "saves the todo list to be loaded later" do
			todo_list.save('/tmp/todo_list.json')
			todo_from_file = TodoList.load('/tmp/todo_list.json')
			expect(todo_from_file.tasks.map(&:title)).to eq todo_list.tasks.map(&:title)
		end

	end

end