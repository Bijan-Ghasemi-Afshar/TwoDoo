module TwoDoo

  class Task 

  	@@number_of_tasks = 0

  	attr_accessor :title, :description, :start_date, :end_date, :label, :finished_date    

    def initialize(title, description, start_date, end_date, label)

      if(validate_mandatory_input(title, end_date))

        @id = title.crypt(end_date.to_s)
        @title = title
        @description = description
        @start_date = start_date
        @end_date = end_date
        @label = label
        @@number_of_tasks += 1        

      else

        raise "Title & End date are mandatory"

      end      

    end        

    def self.number_of_tasks

      @@number_of_tasks

    end

    def to_s

    	"ID: #{@id}\nTitle: #{@title}\nDescription: #{@description}\nStart date: #{@start_date}\nEnd date: #{@end_date}\nLabel: #{@label}\n"

    end

    private

    def validate_mandatory_input(title, end_date)
      
      !title.to_s.empty? and !end_date.to_s.empty? and end_date.is_a?(Time)

    end

  end
  private_constant :Task



  class List

  	def initialize
  		
  		@list_of_tasks = Array.new

  	end

  	def add_task(title, description, start_date, end_date, label)

  		@list_of_tasks.push(Task.new(title, description, start_date, end_date, label))
  		
  	end

    def remove_task
      
      # To be implemented

    end

    def finished_task
      
    end

    def send_notification
      
    end

    def to_s

      rep = "____List____ (#{Task.number_of_tasks} tasks)\n"
      @list_of_tasks.each do |task|
        rep.concat("#{task}\n")
      end
      return rep

    end

  end

end
