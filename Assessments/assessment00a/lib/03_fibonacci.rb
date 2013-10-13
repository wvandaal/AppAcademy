def fibs(num)
	case num
	when 0
		[]
	when 1
		[0]
	else
		fibs = [0, 1]
		while fibs.length < num
			fibs.push(fibs[-2] + fibs[-1])
		end
		fibs
	end
end
