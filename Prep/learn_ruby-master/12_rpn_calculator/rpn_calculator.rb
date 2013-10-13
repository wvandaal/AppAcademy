class RPNCalculator

	def initialize
		@stack = []
	end

 	def push(n)
    	@stack.push(n)
  	end
 
  	def plus
	    a = @stack.pop(2)
	    raise "calculator is empty" if a.empty?
	    @stack << a[0] + a[1]
 	end
 
  	def minus
    	a = @stack.pop(2)
    	raise "calculator is empty" if a.empty?
    	@stack << a[0] - a[1]
  	end
 
  	def times
    	a = @stack.pop(2)
    	raise "calculator is empty" if a.empty?
    	@stack << a[0] * a[1]
  	end
 
  	def divide
    	a = @stack.pop(2)
    	raise "calculator is empty" if a.empty?
    	@stack << a[0].to_f / a[1]
  	end
 
  	def value
    	@stack[-1]
  	end
 
 	def tokens(str)
	  str.split.map! { |t| t[/\d/] ? t.to_i : t.to_sym }
	end

	def evaluate(str)
		tokens(str).each do |t|
			case t
			when Integer
				push(t)
			when :+
				plus
			when :-
				minus
			when :*
				times
			else
				divide
			end
		end
		value	
	end			
end