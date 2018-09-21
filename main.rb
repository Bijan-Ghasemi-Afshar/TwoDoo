Shoes.setup do    
  gem 'os'  
end

$LOAD_PATH << './modules'

require 'TwoDoo'

begin

	list = TwoDoo::List.new	
	puts list

	list.add_task("Task 01", "Task description", "12/09/2018", "14/09/2018", "TwoDoo")

rescue StandardError => e

	puts "______________Error______________\n#{e.message}\n#{e.backtrace.inspect}"

end

Shoes.app title: "TwoDoo" do	
	
	title("The List",
          top:    20,
          align:  "center")			

		@list = stack top: 0.3, margin_left: 20, align: "center" do		
		
			index = 1
			list.list_of_tasks.each do |task|

				flow do
					para "Task #{index}: "
					para (
						link("#{task.title}").click do
							alert(task)
						end
					)
				end

				index += 1
			end

		end			

	@bring_form = button "Add Task", top: 0.8, left: 0.8


	owner_list = @list
	@bring_form.click do
		window title: "Add Task" do

			title("Fill The Form",
			      top:    20,
			      align:  "center")

			@form = stack top: 60, margin: 15 do
				para "Title", margin_top: 15
				@title = edit_line width: 1.0
				para "Description", margin_top: 15
				@description = edit_box width: 1.0
				para "Start Date", margin_top: 15
				@start_date = edit_line width: 1.0
				para "End Date", margin_top: 15
				@end_date = edit_line width: 1.0
				para "Label", margin_top: 15
				@label = edit_line width: 1.0
				@create_task = button "OK", margin_top: 15
			end

			@create_task.click do								
				list.add_task(@title.text, @description.text, @start_date.text, @end_date.text, @label.text)

				# para owner_list

				# owner_list.clear
				# index = 1
				# list.list_of_tasks.each do |task|

				# 	@elem = flow do
				# 		para "Task #{index}: "
				# 		para (
				# 			link("#{task.title}").click do
				# 				alert(task)
				# 			end
				# 		)
				# 	end

				# 	owner_list.append(@elem)

				# 	index += 1
				# end

			end

    end
	end   

end
