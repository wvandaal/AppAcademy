def factors(num)
	(1..num).select{ |i| num % i == 0}
end

def fibs_rec(num)
	return [0] if num == 1
	return [0, 1] if num == 2

	fibs = fibs_rec(num - 1)
	fibs << fibs [-1] + fibs [-2]
end

class Array
	def bubble_sort(&blk)
		self.dup.bubble_sort!(&blk)
	end

	def bubble_sort!(&blk)
		blk ||= Proc.new { |x, y| x <=> y} 
		sorted = false

		until sorted
			sorted = true

			self.each_index do |i|
				break if i == self.count - 1
				if blk.call(self[i], self[i + 1]) == 1
					sorted = false
					self[i], self[i + 1] = self[i + 1], self[i]
				end
			end
		end

		self
	end

	def two_sum
		pairs = []
			(0...self.count).each do |i|
				(i+1...self.count).each do |j|
					pairs << [i,j] if self[i] + self[j] == 0
				end
			end
		pairs.sort
	end
end

class String
	def subword_counts(dictionary)
		subs = Hash.new(0)
		self.length.times.each do |i|
			(i...self.length).each do |j|
				substr = self[i..j] 
				subs[substr] += 1 if dictionary.include?(substr)
			end
		end
		subs
	end
end