$LOAD_PATH << './modules'

require 'TwoDoo'


begin

	list = TwoDoo::List.new
	puts list

	list.add_task("Review Code", "Review code consistansy and proper engineering", "2018-09-06", "2018-09-06", "TwoDoo")
	list.add_task("Remove finished tasks", "Be able to remove finshed tasks", "2018-09-06", "2018-09-07", "TwoDoo")
	list.add_task("Prevent date conflict", "Prevent date conflicts like the end date being before start date", "2018-09-06", "2018-09-10", "TwoDoo")

	# list.remove_task(1)

	# list.finished_task(1)

	# puts list

rescue StandardError => e

	puts "______________Error______________\n#{e.message}\n#{e.backtrace.inspect}"

end
