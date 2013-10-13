def measure(n=1)
	s_time = Time.now
	n.times { yield }
	n > 1 ? (Time.now - s_time)/n : Time.now - s_time  
end