class TimeWindow
	# Define days as class variable 
	@@days = { :Sun=>"Sun", :Mon=>"Mon", :Tue=>"Tue", :Wed=>"Wed", :Thu=>"Thu", :Fri=>"Fri", :Sat=>"Sat" }

	def initialize(time)
		@time_window = parse_multi(time)
	end

	def parse_multi(time)
		time_window_list = []

		if time[/\;/]
			multi_range = time.split(";")
			multi_range.each do |m|
				time_window<< parse_single(m)
			end
		else
			time_window<<parse_single(time)
		end

		time_window
	end

	def parse_single(time)
		time_window
		if time[/\d{4}-\d{4}/]
		
		end


		time[/\D+\-\D+/]

	end


	def include?(time)
		return true if @time_window.empty?

		hour = time.hour
		min = time.min

	end

	



end