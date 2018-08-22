$LOAD_PATH << '.'

require 'TwoDoo'

task_1 = TwoDoo::Task.new('New Task 01', 'This is for testing purposes', nil, nil, 'Test')

puts "Task_1: \n#{task_1}"