class Task

	attr_accessor :title, :priority

	def initialize(title, priority = 10)
		self.title = title
        self.priority = priority
	end

    def completed(task)
        Task.new.completed? == false
    	
    end
   

end