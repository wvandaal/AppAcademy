require 'rspec'
require 'array'

describe "#my_uniq" do

	it "returns an array of uniq numbers" do
		[1, 2, 2, 3, 4, 3, 5].my_uniq.should == [1, 2, 3, 4, 5]
	end

	it  "returns an empty array when passed an empty array" do 
		[].my_uniq.should == []
	end
end

# two_sum returns and array of pairs of positions in an array where the 
# numbers at those positions sum to zero
describe "#two_sum" do
	it "returns an array of positions" do
		[1, 0, -1, 2, 1, 3, 0].two_sum.should == [[0, 2], [1, 6], [2, 4]]
	end

	it "returns an empty array if there are no zero-pairs" do
		[1, 2, 3, 4, 5].two_sum.should == []
	end
end

describe "#my_transpose" do
	it "transposes the array" do
		rows = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8]
  	].my_transpose.should == cols = [[0, 3, 6], [1, 4, 7], [2, 5, 8]]
  end
end

describe "#stock_picker" do
	it "should pick the two indexes of the best buy/sell days" do
			stock_picker([1, 2, 0, 5, 4, 3, 7]).should == [2, 6]
	end

	it "should return an empty array if no prices are given" do
		stock_picker([]).should == []
	end
end

