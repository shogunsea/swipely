require './TimeWindow.rb'
# require 'debugger'

strings = ["Fri-Mon", "Fri-Mon 0900-1000"]#, "Sat-Sun; Mon Wed 0700-0900; Thu 0700-0900 1000-1200"]
strings2 = ["", "Fri-Mon", "Fri-Mon 0900-1000", "Sat-Sun; Mon Wed 0700-0900; Thu 0700-0900 1000-1200 1500-1530; Wed Thu 0700-0900 1000-1200"]

# puts "Testing for first group of strings:"
# strings.each do |s|
# 	a = TimeWindow.new(s)
# end
# puts 
puts "Testing for second group of strings:"
strings2.each do |s|
	a = TimeWindow.new(s)
end
