gem 'rspec'
require 'deck'

describe Deck do

	subject(:deck) {Deck.new}	
	let(:test_hand) {double('test_hand', :cards => deck.deal_new_hand(5)[rand(4)].slice(0..rand(1..4)))}

	describe "#deal_new_hand" do
		it "deals a new hand to each of 5 players" do
			deck.deal_new_hand(5).length.should == 5
		end

		it "each hand has exactly 5 cards" do
			deck.deal_new_hand(5).each do |hand|
				hand.length.should == 5
			end
		end
	end

	describe "#draw_cards" do
		it "deals the appropriate number of cards" do
				deck.draw_cards(test_hand)
				test_hand.cards.length.should == 5
		end
	end

end