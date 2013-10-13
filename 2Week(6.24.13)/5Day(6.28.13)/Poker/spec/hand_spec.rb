gem 'rspec'
require 'hand'
require 'deck'

describe Hand do

	deck = Deck.new
	deck2 = Deck.new
	let(:pair_hand) {Hand.new("Player1", deck.cards[0,2])}
	let(:three_hand) {Hand.new("Player1", deck.cards[0,3])}
	let(:two_pair_hand) {Hand.new("Player1", deck.cards[0..1] + deck.cards[5..6])}
	let(:four_hand) {Hand.new("Player1", deck.cards[0..3])}
	let(:full_house) {Hand.new("Player1", deck.cards[2..6])}
	let(:straight_flush) {Hand.new("Player1", [deck.cards[0], deck.cards[4], 
																						 deck.cards[8], deck.cards[12], 
																						 deck.cards[16]])}
	let(:random_hand1) {Hand.new("Player1", deck2.deal_new_hand(1).flatten)}
	let(:random_hand2) {Hand.new("Player2", deck2.deal_new_hand(1).flatten)}

	describe "#high_card?" do
		it "returns true if player's hand has higher card than opponent" do
			p random_hand1.high_card?(random_hand2)
		end
	end

	describe "#pair?" do
		it "returns the pair if the deck has exactly two of the same card" do
			pair_hand.pair?.should == 2
		end

		it "false if the deck has more than two of the same card" do
			three_hand.pair?.should == false
		end
	end

	describe "#three_of_kind?" do
		it "returns the value of the card if the deck has exactly 3 of the same card" do
			three_hand.three_of_kind?.should == 2
		end

		it "false if the deck has less than 3 of the same card" do
			pair_hand.three_of_kind?.should == false
		end
	end

	describe "#two_pair?" do
		it "returns true if the deck has exactly 2 pair" do
			two_pair_hand.two_pair?.should == [3, 2]
		end

		it "false if the deck has less than 2 pair " do
			pair_hand.two_pair?.should == false
		end
	end

	describe "#four_of_kind?" do
		it "returns the value of the card if the deck has exactly 4 of the same card" do
			four_hand.four_of_kind?.should == 2
		end

		it "false if the deck has less than 4 of the same card" do
			pair_hand.four_of_kind?.should == false
		end
	end

	describe "#is_straight?" do
		it "returns true if the hand has a straight" do
			straight_flush.is_straight?.should == true
		end

		it "returns false if the hand does not have a straight" do
			pair_hand.is_straight?.should == false
		end
	end

	describe "#is_flush?" do
		it "returns true if the hand has a flush" do
			straight_flush.is_flush?.should == true
		end

		it "returns false if the hand does not have a straight" do
			pair_hand.is_straight?.should == false
		end
	end

	describe "#is_full_house?" do
		it "returns true if the hand has a full house" do
			full_house.is_full_house?.should == [3,2]
		end

		it "returns false if the hand does not have a straight" do
			three_hand.is_straight?.should == false
		end
	end

end