module TwoDoo

  class Task 

  	@@number_of_tasks

  	attr_accessor :title, :description, :start_date, :end_date, :label, :finished_date

    def initialize(title='task1', description='', start_date=Time.new, end_date=(Time.new + 30), label='')

			@title = title
			@description = description
			@start_date = start_date
			@end_date = end_date
			@label = label

    end

    def to_s
    	"title: #{title}\ndescription: #{description}\nstart_date: #{start_date}\nend_date: #{end_date}\nlabel: #{label}"
    end

  end

  class List

  	def initialize
  		
  		@list_of_tasks.new

  	end

  	def add_task

  		@list_of_tasks.push(Task.new())
  		
  	end

  end

end
