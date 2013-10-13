require 'card'

# Represents a deck of playing cards.
class Deck
  # Returns an array of all 52 playing cards.
  def self.all_cards
    Card.values.product(Card.suits).map {|val, suit| Card.new(suit, val)}
  end

  def initialize(cards = Deck.all_cards)
    @cards = cards
  end

  # Returns the number of cards in the deck.
  def count
    @cards.count
  end

  # Takes `n` cards from the top of the deck.
  def take(n)
    raise ArgumentError.new "not enough cards" if n > @cards.count
    cards = []
    n.times {cards << @cards.shift}
    cards
  end

  # Returns an array of cards to the bottom of the deck.
  def return(cards)
    @cards += cards
  end
end
