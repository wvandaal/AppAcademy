class Hand

	MAX_CARDS = 5

	attr_accessor :cards, :belongs_to

	def initialize(player, cards = [])
		@belongs_to = player
		@cards = cards
		raise "Too many cards." if @cards.length > MAX_CARDS
	end

	def card_values
		@cards.map {|card| card.num_val}
	end

	def beats?(opponent)
		p self.card_values
		p opponent.card_values
		if self.hand_value > opponent.hand_value
			true
		elsif self.hand_value < opponent.hand_value
			false
		else
			case self.hand_value
			when 8 	# straight flush
				if self.card_values.sort.last == opponent.card_values.sort.last
					return nil
				end
				self.card_values.sort.last > opponent.card_values.sort.last
			when 7	# four of a kind
				self.four_of_kind? > opponent.four_of_kind?
			when 6	# full house
				self.is_full_house?.zip(opponent.is_full_house?).each do |pair|
					if pair[0] - pair[1] > 0
						return true
					elsif pair[0] - pair[1] < 0
						return false
					else next
					end
				end
				nil
			when 5
			end
		end
	end

	
	# returns true if you have the highest non-matching card
	# returns nil in case of a tie		
	def high_card?(opponent)
		p self.card_values
		p opponent.card_values
		p self.card_values.sort.zip(opponent.card_values.sort).reverse
		self.card_values.sort.zip(opponent.card_values.sort).reverse.each do |pair|
			if pair[0] - pair[1] > 0
				return true
			elsif pair[0] - pair[1] < 0
				return false
			else next
			end
		end
		nil
	end	

	# returns numeric value corresponding to how high the 
	# player's hand is
	def hand_value
		return 8 if self.is_straight? && self.is_flush?
		return 7 if self.four_of_kind?
		return 6 if self.is_full_house?
		return 5 if self.is_flush?
		return 4 if self.is_straight?
		return 3 if self.three_of_kind?
		return 2 if self.two_pair?
		return 1 if self.pair?
		0
	end

	def is_full_house?
		pair? && three_of_kind? ? [three_of_kind?, pair?] : false
	end

	def is_flush?
		@cards.all? {|card| card.suit == @cards[0].suit} && @cards.length == 5
	end

	def is_straight?
		vals = card_values
		return false if vals.uniq.length < 5
		diff = vals.max - vals.min
		diff == 4 || diff == 14
	end

	def pair?
		pair = card_values.detect{|x| card_values.count(x) == 2}
		pair.nil? ? false : pair
	end

	def two_pair?
		pairs = [card_values.reverse.
		detect{|x| card_values.count(x) == 2}, card_values.
		detect{|x| card_values.count(x) == 2}].compact.uniq
		(pairs.empty? || pairs.length < 2) ? false : pairs
	end

	def three_of_kind?
		three = card_values.detect{|x| card_values.count(x) == 3}
		three.nil? ? false : three
	end

	def four_of_kind?
		four = card_values.detect{|x| card_values.count(x) == 4}
		four.nil? ? false : four
	end
end