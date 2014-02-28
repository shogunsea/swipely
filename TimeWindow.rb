# require 'debugger'

class TimeWindow
	# Define days as class variable 
	@@days = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]

	def initialize(time)
		@time_window = parse_multi(time)
	end

	def parse_multi(time)
		time_window_list = []

		if time[/\;/]
			multi_range = time.split(";")
			multi_range.each do |m|
				time_window_list<< parse_single(m)
			end
		else
			time_window_list<<parse_single(time)
		end

		time_window_list
	end

	def parse_single(time)
		time_window = {} #[]?

		if time[/\D+\-\D+/]
			day_range = time[/\D+\-\D+/].strip
			days = day_range.split("-")
			# Get index from starting day and ending day
			# debugger
			start_index = @@days.index days[0]
			end_index = @@days.index days[1]
			# Add all days in the day range.
			if start_index>end_index
				for i in start_index..6
					day = @@days[i]
					# Set default time range.
					time_window["#{day}"] = { "start" => 000000, "end" => 235959 }
				end
				for i in 0..end_index
					day = @@days[i]
					# Set default time range.
					time_window["#{day}"] = { "start" => 000000, "end" => 235959 }
				end

			else
				for i in start_index..end_index 
					day = @@days[i]
					# Set default time range.
					time_window["#{day}"] = { "start" => 000000, "end" => 235959 }
				end
			end

			# debugger
			if time[/\d{4}-\d{4}/]
				time_window.each do |day, time|
					p "#{day}   #{time}"
				end

			end
		end
	end


	def include?(time)
		return true if @time_window.empty?

		hour = time.hour
		min = time.min

	end

	



end