Shoes.setup do    
  gem 'os'  
end

$LOAD_PATH << './modules'

require 'TwoDoo'

begin

	list = TwoDoo::List.new			

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
					para "Task #{index}:"
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


	list_column = @list
	task_column = @task_column
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

				list_column.clear {
					index = 1
					list.list_of_tasks.each do |task|

						list_column.flow do
							list_column.para "Task #{index}:"
							list_column.para (
								link("#{task.title}").click do
									alert(task)
								end
							)					
						end

						index += 1
					end
				}
				
				close

			end

    end
	end   

end
