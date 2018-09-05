require 'date'
require 'json'
require 'digest/sha1'

module TwoDoo

  class Task 

  	@@number_of_tasks = 0

  	attr_accessor :id, :title, :description, :start_date, :end_date, :label, :finished_date    
    
    def initialize(title, description, start_date, end_date, label)
     
      @title = title
      @description = description
      @start_date = DateTime.parse(start_date)
      @end_date = DateTime.parse(end_date)
      @label = label
      @id = Task.generate_id(@title, @end_date)
      @@number_of_tasks += 1

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

    def to_hash

      hash = {"id" => id, "title" => title, "description" => description, "start_date" => start_date, "end_date" => end_date, "label" => label}
      
    end

    def self.validate_input(title, start_date_str, end_date_str)
      
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

    def self.generate_id(title, end_date)
        end_date_str = end_date.to_s.gsub(/\s+/, '')
        title_str = title.gsub(/\s+/, '')        
        base = end_date_str.concat(title_str)        
        Digest::SHA1.hexdigest(base)
    end        

  end  
  private_constant :Task



  class List

  	def initialize
  		
  		@list_of_tasks = Array.new
      read_data()

  	end    
    
  	def add_task(title, description, start_date, end_date, label)                

      throw :invalid_data unless Task.validate_input(title, start_date, end_date)

      catch :invalid_data do        

        if check_for_duplicate(title, end_date)
        
          @list_of_tasks.push(Task.new(title, description, start_date, end_date, label))
          store_data()

        end     

      end      
  		
  	end

    def remove_task(index)
      
      # Also needs to be removed from the data file
      if @list_of_tasks.index(index)
        @list_of_tasks.delete_at(index)
        Task.remove_task
      end      

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
      index = 1
      @list_of_tasks.each do |task|
        rep.concat("Task: #{index}\n#{task}\n")
        index += 1
      end
      return rep

    end

    private
    
    def read_data()
            
      if File.exist?("/home/#{ENV['USER']}/.TwoDoo/test_data2.json")

        test_data_json = File.read("/home/#{ENV['USER']}/.TwoDoo/test_data2.json")      
        test_data = JSON.parse(test_data_json)  

        test_data["List"].each do |task|        
          
          @list_of_tasks.push(Task.new(task["title"], task["description"], task["start_date"], task["end_date"], task["label"]))

        end      

      end      

    end
        
    def store_data()

      file_path = "/home/#{ENV['USER']}/.TwoDoo/test_data2.json"
      
      list_hash = to_hash @list_of_tasks      
      task_json = JSON.generate(list_hash)
      File.write(file_path, task_json)
      
    end

    def check_for_duplicate(title, end_date)
        duplicate = true
        new_task_id = Task.generate_id(title, DateTime.parse(end_date))
        @list_of_tasks.each do |task|

          if task.id == new_task_id
            duplicate = false
            puts "This task already exists"
            break
          end

        end
        duplicate
    end

    def to_hash list

      tasks_hash = Array.new
      list.each do | element |                

        tasks_hash.push element.to_hash

      end
      
      {"List" => tasks_hash}

    end

  end

end
