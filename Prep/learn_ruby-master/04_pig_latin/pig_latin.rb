def translate(s)
	alphabet = ("a".."z").to_a
	vowels = %w[a e i o u]
  	consonants = alphabet - vowels
  	s_ary = s.split(" ")

  	s_ary.map! do |w|
	  	if vowels.include?(w[0])
	    	w + "ay"
	    elsif !w[0..2].match(/[aeiou]/) || (w[0..2].match(/(qu)/) && w.index("qu") == 1)
	    	w[3..-1] + w[0..2] + "ay"	   		
	 	elsif (consonants.include?(w[0]) && consonants.include?(w[1])) || (w[0..2].match(/(qu)/) && w.index("qu") == 0)
	    	w[2..-1] + w[0..1] + "ay"
	 	elsif consonants.include?(w[0])
	    	w[1..-1] + w[0] + "ay"
	  	end
	end
	s_ary.join(" ")
end