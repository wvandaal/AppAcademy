def add (num1, num2)
	num1 + num2
end

def subtract(num1, num2)
	num1 - num2
end

def sum(numbers)
	numbers.reduce(:+) || 0
end

def multiply(numbers)
	numbers.reduce(:*)
end

def power(base, exp)
	base ** exp
end

def factorial(n)
	(1..n).reduce(:*) || 1
end