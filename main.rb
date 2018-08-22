$LOAD_PATH << '.'

require 'TwoDoo'

list = TwoDoo::List.new

begin
	
	list.add_task('New Task 01', 'This is for testing purposes 01', nil, Time.new, 'Test_01')
	# list.add_task('New Task 02', 'This is for testing purposes 02', nil, nil, 'Test_02')
	puts list

rescue Exception => e
	
	puts "______________There was an error______________\n#{e.message}\n#{e.backtrace.inspect}"
	# retry

end
