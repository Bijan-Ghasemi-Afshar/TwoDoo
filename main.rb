$LOAD_PATH << './modules'

require 'TwoDoo'


begin				

	list = TwoDoo::List.new	
	puts list

rescue StandardError => e
	
	puts "______________Error______________\n#{e.message}\n#{e.backtrace.inspect}"

end
