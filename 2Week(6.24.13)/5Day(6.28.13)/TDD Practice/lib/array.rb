
class Array
	def my_uniq
		uniqs = []
		self.each do |elem|
			unless uniqs.include?(elem)
				uniqs << elem
			end
		end
		uniqs
	end

	def two_sum
		two_sums = []
		self.each_with_index do |elem, i|
			(i + 1...length).each do |j|
				two_sums << [i, j] if self[i] + self[j] == 0
			end
		end
		two_sums
	end

	def my_transpose
		cols = Array.new(self[0].length) {Array.new(length)}
		self.each_with_index do |row, i|
			row.each_index do |j|
				cols[j][i] = self[i][j]
			end
		end
		cols
	end
end

def stock_picker(prices)
	max_diff = 0
	pair = []
	prices.each_with_index do |buy, i|
		(i + 1...prices.length).each do |j|
			if prices[j] - prices[i] > max_diff
				max_diff = prices[j] - prices[i]
				pair = [i, j]
			end
		end
	end
	pair
end
