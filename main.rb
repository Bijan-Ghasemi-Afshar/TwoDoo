$LOAD_PATH << './modules'

require 'TwoDoo'

list = TwoDoo::List.new

begin				
	
	puts list


rescue Exception => e
	
	puts "______________Error______________\n#{e.message}\n#{e.backtrace.inspect}"
	# retry

end
