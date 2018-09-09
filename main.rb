$LOAD_PATH << './modules'

require 'TwoDoo'

begin

	list = TwoDoo::List.new
	puts list

	# list.add_task("Review Code", "Review code consistansy and proper engineering", "2018-09-06", "2018-09-06", "TwoDoo")
	# list.add_task("Remove finished tasks", "Be able to remove finshed tasks", "2018-09-06", "2018-09-07", "TwoDoo")
	# list.add_task("Prevent date conflict", "Prevent date conflicts like the end date being before start date", "2018-09-06", "2018-09-10", "TwoDoo")
	# list.add_task("Console support", "Make the app to work with console commands BITCH", "2018-09-10", "2018-09-11", "TwoDoo")

	# list.remove_task(1)

	# list.finished_task(1)

	# puts list

rescue StandardError => e

	puts "______________Error______________\n#{e.message}\n#{e.backtrace.inspect}"

end

# Shoes.app title: "TwoDoo" do
# 	background "#5d6066"
# 	title("The List",
#           top:    20,
#           align:  "center",
#           stroke: white)

# 	@list = stack margin: 10, align: "center" do

# 		# list.each do |task|
# 		# 	para task
# 		# end

# 	end

# 	@bring_form = button "Add Task", top: 0.8, left: 0.8

# 	@bring_form.click do
# 		window title: "Add Task" do
# 			background "#5d6066"
# 			title("Fill The Form",
#           top:    20,
#           align:  "center",          
#           stroke: white)
# 			@form = stack top: 60, margin: 15 do
# 				para "Title", stroke: white, margin_top: 15
# 				@title = edit_line width: 1.0
# 				para "Description", stroke: white, margin_top: 15
# 				@description = edit_box width: 1.0
# 				para "Start Date", stroke: white, margin_top: 15
# 				@start_date = edit_line width: 1.0
# 				para "End Date", stroke: white, margin_top: 15
# 				@end_date = edit_line width: 1.0
# 				para "Label", stroke: white, margin_top: 15
# 				@label = edit_line width: 1.0
# 				@create_task = button "OK", margin_top: 15
# 			end
#     end
# 	end   

#  end
