require 'date'
require 'json'

module TwoDoo

  class Task 

  	@@number_of_tasks = 0

  	attr_accessor :title, :description, :start_date, :end_date, :label, :finished_date    

    # TODO: fix id
    def initialize(title, description, start_date, end_date, label)

      throw :invalid_data unless validate_input(title, start_date, end_date)

      catch :invalid_data do

        @id = title.crypt(end_date.to_s)
        @title = title
        @description = description
        @start_date = DateTime.parse(start_date)
        @end_date = DateTime.parse(end_date)
        @label = label
        @@number_of_tasks += 1

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
    
    def validate_input(title, start_date_str, end_date_str)
      
      begin

        if !title.to_s.empty? and !end_date_str.to_s.empty?                  

          DateTime.parse(start_date_str)
          DateTime.parse(end_date_str)
          return true

        else

          raise 'Title & end date are mandatory'

        end       
        
      rescue ArgumentError => e

        puts "______________Error______________\n#{e.message}\nProvide valid date"

      rescue StandardError => e
                        
        puts "______________Error______________\n#{e.message}"        

      end      

    end

  end
  private_constant :Task



  class List

  	def initialize
  		
  		@list_of_tasks = Array.new
      read_data()

  	end    

    # TODO: This must write to the data file
  	def add_task(title, description, start_date, end_date, label)

  		@list_of_tasks.push(Task.new(title, description, start_date, end_date, label))
  		
  	end

    def remove_task(index)
      
      # Also needs to be removed from the data file
      @list_of_tasks.delete_at(index)
      Task.remove_task

    end

    # TODO: This must write to the data file under Finished_List + the finished date
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

    private

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


  end

end
