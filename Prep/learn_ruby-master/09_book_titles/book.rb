class Book
	attr_accessor :title
	LOWER = ["and", "or", "the", "of", "to", "the", "a", "over", "in", "an"]
	
	def initialize(t=nil)
		@title = title=(t)
	end

	def title
		@title
	end

	def title=(t)
		@title = t.empty? ? nil : t.capitalize.split(" ").each{ |word| LOWER.include?(word) ? word : word.capitalize!}.join(" ")
	end
end