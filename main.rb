$LOAD_PATH << './modules'

require 'TwoDoo'


begin				

	list = TwoDoo::List.new	
	puts list
	# list.remove_task(5)
	list.add_task("Writde remove task", "Write the remove task feature to remove tasks from the file", "2018-09-01", "2018-09-02", "TwoDoo")
	# list.add_task("Prevent date conflict", "Prevent date conflicts like the end date being before start date", "2018-09-01", "2018-09-05", "TwoDoo")
	# puts list

rescue StandardError => e
	
	puts "______________Error______________\n#{e.message}\n#{e.backtrace.inspect}"

end
