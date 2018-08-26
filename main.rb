$LOAD_PATH << './modules'

require 'TwoDoo'


begin				

	list = TwoDoo::List.new	
	puts list
	# list.add_task("ID generation", "Write a method to generate id & prevent duplication", "2018-09-26", "2018-08-28", "TwoDoo")
	# puts list

rescue StandardError => e
	
	puts "______________Error______________\n#{e.message}\n#{e.backtrace.inspect}"

end
