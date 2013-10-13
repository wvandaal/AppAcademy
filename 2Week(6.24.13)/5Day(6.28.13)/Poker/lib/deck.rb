# encoding: UTF-8

require_relative 'card.rb'

class Deck

	HAND_SIZE = 5
	PLAYER_MAX = 6

	attr_reader :cards

	def initialize
		@cards = build_deck
	end

	# shuffles the deck and deals num hands of 5 cards each
	def deal_new_hand(num)
		raise "The maximum number of players is 6." if num > PLAYER_MAX
		deal = Array.new(num) {[]}
		@cards.shuffle!
		HAND_SIZE.times do
			deal.each do |hand|
				hand << @cards.shift
			end
		end
		deal
	end

	#deals cards to the given hand until it has 5 cards
	def draw_cards(hand)
		raise "You already have 5 cards." if hand.cards.length >= 5
		until hand.cards.length == 5
			hand.cards << @cards.shift
		end
	end

	def bury_cards(cards)
		cards.each {|card| @cards << card}
	end

	private

	def build_deck
		Card.all_possible.map do |val, suit|
			Card.new(val, suit)
		end
	end

end