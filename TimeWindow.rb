# require 'debugger'

class TimeWindow
	# Define days as class variable 
	@@days = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]

	def initialize(time)
		@time_window = parse_multi(time)
	end

	def parse_multi(time)
		time_window_list = []

		if time.strip=="" 
			return time_window_list
		end

		if time[/\;/]
			multi_range = time.split(";")
			multi_range.each do |m|
				# debugger
				time_window_list<< parse_single(m.strip)
			end
		else
			time_window_list<<parse_single(time)
		end

		# puts "time window for one input: #{time_window_list}"

		time_window_list
	end

	def parse_single(time)
		time_window = {}   #[]?

		# Day range condtion, "Fri-Mon"
		if time[/\D+\-\D+/]
			day_range = time[/\D+\-\D+/].strip
			days = day_range.split("-")
			# Get index from starting day and ending day
			start_index = @@days.index days[0]
			end_index = @@days.index days[1]
			# Add all days in the day range.
			if start_index>end_index
				for i in start_index..6
					day = @@days[i]
					# Set default time range.
					time_window["#{day}"] ||=[]
					time_window["#{day}"] << { "start" => "0", "end" => "240000" }
				end
				for i in 0..end_index
					day = @@days[i]
					# Set default time range.
					time_window["#{day}"] ||=[]
					time_window["#{day}"] << { "start" => "0", "end" => "240000" }
				end

			else
				for i in start_index..end_index 
					day = @@days[i]
					# Set default time range.
					time_window["#{day}"] ||= []
					time_window["#{day}"] << { "start" => "0", "end" => "240000" }
				end
			end
		# Contains seperate days. Weaker condition.
		elsif time[/\D+/]
			days = time[/\D+/].strip.split(" ")
			days.each do |day|
				time_window["#{day}"] ||=[]
				time_window["#{day}"] << { "start" => "0", "end" => "235959" }
			end
		end

		# Contains multiple time ranges.
		if time.split(/\d{4}-\d{4}/).size>1
			# debugger
			# p "time_window size is: #{time_window.size}"
			time_ranges = time[/\d.*/].strip.split(" ")
			# Fill missing time range in the time window.
			time_range_count = time_ranges.size
			# p "Default hash of time_window is: #{default_hash}"
			for i in 1..time_range_count-1
				time_window.each do |day, range_lists|
					range_lists<<{"start"=>"","end"=>""}
				end
			end
			# debugger
			# p "time_ranges size: #{time_ranges.size}, range_lists size: #{time_window.values.first.size}"
			time_ranges.each_with_index do |time_range, index|
				time_string = time_range.split("-")
				start_time = time_string[0]
				end_time = time_string[1]
				time_window.each do |day, range_lists|
					# debugger
					range_lists[index]["start"] =start_time+"00"
					range_lists[index]["end"]  = end_time+"00"
				end
			end

		# Contains only one time range, weaker condition.
		elsif time[/\d{4}-\d{4}/]
			# debugger
			time_string = time[/\d{4}-\d{4}/].strip.split("-")
			start_time = time_string[0]
			end_time = time_string[1]
			time_window.each do |day, range_lists|
				range_lists.each do |l|
					l["start"] = start_time+"00"
					l["end"] = end_time+"00"
				end
			end
		end
		
		# puts "Time window for: #{time}"

		# time_window.each do |day, time|
		# 	puts "#{day}   #{time}"
		# end
		time_window
	end

	def include?(time)
		# debugger
		return true if @time_window.empty?

		day = ""
		if time.sunday?
			day = "Sun"
		elsif time.monday?
			day = "Mon"
		elsif time.tuesday?
			day = "Tue"
		elsif time.wednesday?
			day = "Wed"
		elsif time.thursday?
			day = "Thu"
		elsif time.friday?
			day = "Fri"
		elsif time.saturday?
			day = "Sat"
		end

		time_string = time.strftime "%H%M%S"

		# debugger
		result = false

		@time_window.each do |time_range|
			# Day matching.
			time_range.each do |day_in_window, range_lists|
				if day==day_in_window
					range_lists.each do |time_hash|
						start_time  = time_hash["start"]
						end_time = time_hash["end"]

						if time_string.to_i>=start_time.to_i && time_string.to_i<end_time.to_i
							result = true
							return result
						end

					end
				end
			end
		end
		# p 'sss'
		result 
	end
end