class Timer
	attr_accessor :seconds

	def initialize
		@seconds = 0
	end

	def seconds=(sec)
		@seconds = sec
	end

	def time_string
		hours = padded(@seconds/3600)
		min = padded(@seconds%3600/60)
		sec = padded(@seconds%3600%60)
		"#{hours}:#{min}:#{sec}"
	end

	# private 

	def padded(t)
		t.to_s.rjust(2,'0')
	end

end