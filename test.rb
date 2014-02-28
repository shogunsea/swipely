require './TimeWindow.rb'
# require 'debugger'

strings = ["", "Fri-Mon", "Fri-Mon 0900-1000", "Sat-Sun; Mon Wed 0700-0900; Thu 0700-0900 1000-1200"]

strings.each do |s|
	a = TimeWindow.new(s)
end
