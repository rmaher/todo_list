class Task

	attr_accessor :title, :priority

	def initialize(title, priority = 10)
		self.title = title
        self.priority = priority
        @completed = false
	end

    def complete
        @completed = true
    end

    def complete?
    	@completed
    end
   

end