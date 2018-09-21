require 'date'
require 'json'
require 'digest/sha1'
require 'os'
require 'fileutils'

module TwoDoo

  class Task

  	@@number_of_tasks = 0
    @@number_of_finished_tasks = 0

  	attr_accessor :id, :title, :description, :start_date, :end_date, :label, :finished_date

    def initialize(title, description, start_date, end_date, finished_date, label)

      @title = title
      @description = description
      @start_date = DateTime.parse(start_date)
      @end_date = DateTime.parse(end_date)
      @label = label
      @id = Task.generate_id(@title, @end_date)
      @finished_date = finished_date.nil? ?  nil : DateTime.parse(finished_date)
      @@number_of_tasks += 1 if @finished_date.nil?

    end

    def self.number_of_tasks

      @@number_of_tasks

    end

    def self.remove_task

      @@number_of_tasks -= 1 if @@number_of_tasks > 0

    end

    def finished_task

      @@number_of_finished_tasks += 1
      @finished_date = DateTime.now()

    end

    def to_s

      if @finished_date.nil?
        "Title: #{@title}\nDescription: #{@description}\nStart date: #{@start_date.strftime("%d/%m/%Y %H:%M")}\nEnd date: #{@end_date.strftime("%d/%m/%Y %H:%M")}\nLabel: #{@label}\n"
      else
        "Title: #{@title}\nDescription: #{@description}\nStart date: #{@start_date.strftime("%d/%m/%Y %H:%M")}\nEnd date: #{@end_date.strftime("%d/%m/%Y %H:%M")}\nFinished date: #{@finished_date.strftime("%d/%m/%Y %H:%M")}\nLabel: #{@label}\n"
      end

    end

    def to_hash

      if @finished_date.nil?
        hash = {"id" => @id, "title" => @title, "description" => @description, "start_date" => @start_date, "end_date" => @end_date, "label" => @label}
      else
        hash = {"id" => @id, "title" => @title, "description" => @description, "start_date" => @start_date, "end_date" => @end_date, "finished_date" => @finished_date, "label" => @label}
      end

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

    attr_reader :list_of_tasks

  	def initialize

  		@list_of_tasks = Array.new
      @list_of_finished_tasks = Array.new
      read_data      

  	end

  	def add_task(title, description, start_date, end_date, label)

      throw :invalid_data unless Task.validate_input(title, start_date, end_date)

      catch :invalid_data do

        if check_for_duplicate(title, end_date)

          @list_of_tasks.push(Task.new(title, description, start_date, end_date, nil, label))
          store_data

        end

      end

  	end

    def remove_task(index)

      begin
        @list_of_tasks.delete_at(index-1)
        Task.remove_task
        store_data
      rescue StandardError => e
        puts "______________Error______________\nThe task doesn't exist\n#{e.message}\n#{e.backtrace.inspect}"
      end

    end

    def finished_task(index)

      begin
        task = @list_of_tasks.at(index-1)
        task.finished_task
        @list_of_finished_tasks.push(task)
        @list_of_tasks.delete_at(index-1)
        Task.remove_task
        store_data
      rescue StandardError => e
        puts "______________Error______________\nThe task doesn't exist\n#{e.message}\n#{e.backtrace.inspect}"
      end

    end

    #TODO: To be implemented after GUI
    def send_notification


    end

    def get_task(index)
      
      @list_of_tasks.at(index-1) if index > 0

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

      file_path = get_data_path      

      if File.exist?(file_path)

        test_data_json = File.read(file_path)
        test_data = JSON.parse(test_data_json)

        test_data["List"].each do |task|

          @list_of_tasks.push(Task.new(task["title"], task["description"], task["start_date"], task["end_date"], nil, task["label"]))

        end

        test_data["Finished_list"].each do |task|

          @list_of_finished_tasks.push(Task.new(task["title"], task["description"], task["start_date"], task["end_date"], task["finished_date"], task["label"]))

        end

      end

    end

    def store_data()
      
      file_path = get_data_path

      all_data = generate_hash
      task_json = JSON.generate(all_data)      

      FileUtils.mkdir(get_data_directory_path) if(!File.exist?(get_data_directory_path))

      File.open(file_path, "w") {|f| f.write(task_json) }

    end

    def get_data_path

      file_path = "/home/#{ENV['USER']}/.TwoDoo/list_data.json" if OS.linux?

      file_path = "C:\\Users\\#{ENV['USER']}\\AppData\\Local\\TwoDoo\\list_data.json" if OS.windows?

      file_path = "/Users/#{ENV['USER']}/Library/Application Support/.TwoDoo/list_data.json" if OS.mac?
      
      return file_path

    end

    def get_data_directory_path 

      file_path = "/home/#{ENV['USER']}/.TwoDoo" if OS.linux?

      file_path = "C:\\Users\\#{ENV['USER']}\\AppData\\Local\\TwoDoo" if OS.windows?

      file_path = "/Users/#{ENV['USER']}/Library/Application Support/.TwoDoo" if OS.mac?
      
      return file_path

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

    def generate_hash

      all_data = Hash.new
      task_array = Array.new
      @list_of_tasks.each do | element |

        task_array.push element.to_hash

      end
      all_data["List"] = task_array


      task_array = Array.new
      @list_of_finished_tasks.each do | element |

        task_array.push element.to_hash

      end
      all_data["Finished_list"] = task_array


      all_data

    end

  end

end
