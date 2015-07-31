require "spec_helper"
require "json"

describe TodoListController do
	let(:controller){ TodoListController.new }

	describe "#save" do

		it "saves the list" do
			expect(controller.todo_list).to receive(:save)
			controller.save(['/some/file'])
		end

		it "notifies the user the file was saved" do
			expect(controller.todo_list).to receive(:save).and_return(true)
			expect(STDOUT).to receive(:puts).with("\n\nFile Saved\n\n")
			controller.save(['/some/file'])
		end

	end

	describe "#load" do

		it "loads the list" do
			expect(TodoList).to(receive(:load)).and_return(TodoList.new)
			controller.load(['/some/file'])
		end

		it "displays the list so the user sees the result" do
			expect(controller).to receive(:list)
			expect(TodoList).to receive(:load).and_return(TodoList.new)
			controller.load(['/some/file'])
		end

	end

	describe "#complete" do
		let(:todo_list) { TodoList.new }
		let(:task1){ Task.new('Buy Milk') }
		before do
			controller.todo_list = todo_list
			todo_list.add(task1)
		end

		it "completes a task" do
			expect(task1).to receive(:complete)
			expect(controller).to receive(:list)

			controller.complete([1])
		end
	end

	describe "#list" do
		let(:todo_list) { TodoList.new }
		let(:task1){ Task.new('Buy Milk') }
		let(:task2){ Task.new('Buy Cheese') }
		before do
			controller.todo_list = todo_list
			task2.complete
			todo_list.add(task1)
			todo_list.add(task2)
		end

		it "displays each task" do
			expect(STDOUT).to receive(:puts).with("\n\n")
			expect(STDOUT).to receive(:puts).with("Listing tasks:")
			expect(STDOUT).to receive(:puts).with("----------------------------------------------------------------------------------------------")
			expect(STDOUT).to receive(:puts).with("1 Buy Milk priority: 10")
			expect(STDOUT).to receive(:puts).with("2 Buy Cheese priority: 10 --completed!")
			expect(STDOUT).to receive(:puts).with("\n\n")

			controller.list
		end
	end

	describe "#add" do
		let(:task){ Task.new('Buy Milk')}
		it "adds a task to the todo list" do
			expect(Task).to receive(:new).with('Buy Milk').and_return(task)
			expect(controller.todo_list).to receive(:add).with(task)
			controller.add(['Buy Milk'])
		end
	end

	describe "#run" do

		it "exits the loop if the user types 'exit'" do
			expect(STDIN).to receive(:gets).and_return('exit')
			controller.run
		end

		it "calls the load method when the user types 'load'" do
			expect(controller).to receive(:load).and_return(TodoList.new)
			expect(STDIN).to receive(:gets).and_return('load /some/file')
			expect(STDIN).to receive(:gets).and_return('exit')
			controller.run
		end

		it "calls the save method when the user types 'save'" do
			expect(controller).to receive(:save).and_return(true)
			expect(STDIN).to receive(:gets).and_return('save /some/file')
			expect(STDIN).to receive(:gets).and_return('exit')
			controller.run
		end

		it "calls the list method when the user types 'list'" do
			expect(controller).to receive(:list).and_return(true)
			expect(STDIN).to receive(:gets).and_return('list')
			expect(STDIN).to receive(:gets).and_return('exit')
			controller.run
		end

		it "calls the complete method when the user types 'complete'" do
			expect(controller).to receive(:complete).and_return(true)
			expect(STDIN).to receive(:gets).and_return('complete 1')
			expect(STDIN).to receive(:gets).and_return('exit')
			controller.run
		end

		it "calls the add method when the user types 'add'" do
			expect(controller).to receive(:add).with(['Buy','Cheese']).and_return(true)
			expect(STDIN).to receive(:gets).and_return('add Buy Cheese')
			expect(STDIN).to receive(:gets).and_return('exit')
			controller.run
		end

	end

end