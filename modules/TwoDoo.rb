require 'date'
require 'json'

module TwoDoo

  class Task 

  	@@number_of_tasks = 0

  	attr_accessor :title, :description, :start_date, :end_date, :label, :finished_date    

    def initialize(title, description, start_date, end_date, label)

      if(validate_mandatory_input(title, end_date))

        @id = title.crypt(end_date.to_s)
        @title = title
        @description = description
        @start_date = DateTime.parse(start_date)
        @end_date = DateTime.parse(end_date)
        @label = label
        @@number_of_tasks += 1        

      else

        raise "Title & End date are mandatory"

      end      

    end        

    def self.number_of_tasks

      @@number_of_tasks

    end

    def self.remove_task
      
      @@number_of_tasks -= 1

    end

    def to_s

    	"ID: #{@id}\nTitle: #{@title}\nDescription: #{@description}\nStart date: #{@start_date.strftime("%d/%m/%Y %H:%M")}\nEnd date: #{@end_date.strftime("%d/%m/%Y %H:%M")}\nLabel: #{@label}\n"

    end

    private

    # TODO: Add better error handling
    def validate_mandatory_input(title, end_date_str)
      
      if(!title.to_s.empty? and !end_date_str.to_s.empty?)                

        end_date = DateTime.parse(end_date_str)
        return true

      else

        puts 'No'
        return false

      end      

    end

  end
  private_constant :Task



  class List

  	def initialize
  		
  		@list_of_tasks = Array.new
      read_data()

  	end

    # This must read from the data file
    def read_data()
      
      test_data_file = File.open("/home/#{ENV['USER']}/.TwoDoo/test_data.json", "r")
      test_data_json = test_data_file.read()
      test_data_file.close()

      test_data = JSON.parse(test_data_json)  

      test_data["List"].each do |task|        
        
        @list_of_tasks.push(Task.new(task["title"], task["description"], task["start_date"], task["end_date"], task["label"]))

      end      

    end

    # TODO: This must write to the data file
  	def add_task(title, description, start_date, end_date, label)

  		@list_of_tasks.push(Task.new(title, description, start_date, end_date, label))
  		
  	end

    def remove_task(index)
      
      # Also needs to be removed from the database
      @list_of_tasks.delete_at(index)
      Task.remove_task

    end

    def finished_task
      
      @list_of_tasks.delete_at(index)
      Task.remove_task

    end

    def send_notification
      
      # To be implemented

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
