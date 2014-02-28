require './TimeWindow.rb'
# require 'debugger'

strings = ["Fri-Mon", "Fri-Mon 0900-1000"]#, "Sat-Sun; Mon Wed 0700-0900; Thu 0700-0900 1000-1200"]
strings2 = ["Sat-Sun; Mon Wed 0700-0900; Thu 0700-0900 1000-1200"]
# puts "Testing for first group of strings:"
# strings.each do |s|
# 	a = TimeWindow.new(s)
# end
# puts 
# puts "Testing for second group of strings:"
strings2.each do |s|
	ins = TimeWindow.new(s)

	test_time = Time.mktime(2007,9,29,23,59,59)

	p ins.include? test_time

end
