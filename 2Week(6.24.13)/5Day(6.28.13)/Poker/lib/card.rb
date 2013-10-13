# encoding: UTF-8

require 'colorize'

class Card

	VALUES = {2 => 2, 3 => 3, 4 => 4, 5 => 5,
						6 => 6, 7 => 7, 8 => 8, 9 => 9,
						10 => 10, J: 11, Q: 12, K: 13, A: 14}

	SUITS = {hearts: ["♥", :red], spades: ["♠", :black],
					 diamonds: ["♦", :red], clubs: ["♣", :black]}

	attr_reader :suit, :value

	def initialize(value, suit)
		@value = value
		@suit = suit
		raise "Invalid card value." if VALUES[value].nil?
		raise "Invalid card suit." unless SUITS.include?(suit)
	end

	def display
		"#{@value}#{SUITS[@suit][0].colorize(SUITS[@suit][1])} "
	end

	def num_val
		VALUES[@value]
	end

	def self.all_possible
		VALUES.keys.product(SUITS.keys)
	end
end
