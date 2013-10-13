class Temperature
	attr_accessor :f, :c 

	def initialize(attributes = {})
		@f = attributes[:f]
		@c = attributes[:c]
	end

	def in_fahrenheit
		@f.nil? ? @c*9/5.0 + 32 : @f
	end

	def in_celsius
		@c.nil? ? ((@f - 32)*5/9.0) : @c
	end

	def self.in_fahrenheit
		@f.nil? ? ctof(@c) : @f
	end

	def self.in_celsius
		@c.nil? ? ftoc(@f) : @c
	end

	def self.from_fahrenheit(temp)
		@f = temp
		@c = ftoc
		self
	end

	def self.from_celsius(temp)
		@c = temp
		@f = ctof
		self
	end

	private

	def self.ftoc
		(@f - 32)*5/9.0
	end

	def self.ctof
		@c*9/5.0 + 32
	end		
end

class Fahrenheit < Temperature
	def initialize(temp)
		@f = temp
	end
end

class Celsius < Temperature
	def initialize(temp)
		@c = temp
	end
end
