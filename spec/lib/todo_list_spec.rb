require "spec_helper"

describe TodoList do
	let(:todo_list){ TodoList.new }

	before do
		todo_list.add(Task.new("Pay bills", 1))
		todo_list.add(Task.new("Buy milk", 2))
	end

	it "stores tasks" do
		expect(todo_list.tasks.map(&:title)).to include("Pay bills", "Buy milk")
	end

end