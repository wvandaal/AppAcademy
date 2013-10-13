def digital_root(num)
	while num > 10
		num = digital_root_step(num)
	end
	num
end

private

def digital_root_step(n)
	step = 0
	while n > 0
		step += n % 10
		n /= 10
	end
	step
end
