gem 'rspec'
require 'card'

describe Card do


	it "should raise an exception if the suit is wrong" do
		expect {Card.new(:A, "Hearts")}.to raise_error
	end

	it "should raise an exception if the value is wrong" do
		expect {Card.new(:Z, :hearts)}.to raise_error
	end

	subject(:card) {Card.new(:A, :hearts)}

	its(:value) {should == :A}
	its(:suit) {should == :hearts}

	describe "#num_val" do 
		it "should initialize the correct card value" do
			card.num_val.should == 14
		end
	end

	describe "#all_possible" do
		it "should output all possible value/suit combinations" do
			VALUES = [2, 3, 4, 5, 6, 7, 8, 9, 10, :J, :Q, :K, :A]
			SUITS = [:hearts, :spades, :diamonds, :clubs]
			Card.all_possible.should == VALUES.product(SUITS)
		end
	end
end