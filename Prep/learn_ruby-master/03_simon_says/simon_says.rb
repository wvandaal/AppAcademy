def echo(s)
	s
end

def shout(s)
	s.upcase
end

def repeat(s, n = 2)
	s + (" #{s}")*(n-1)
end

def start_of_word(s, n)
	s[0..n-1]
end

def first_word(s)
	s.split(" ").first
end

def titleize(s)
	lowercase = ["and", "or", "the", "of", "to", "the", "a", "over"]
	s.capitalize.split(" ").each{ |word| lowercase.include?(word) ? word : word.capitalize!}.join(" ")
end
