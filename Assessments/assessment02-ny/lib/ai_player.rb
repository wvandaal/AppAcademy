# Represents a computer Crazy Eights player.
class AIPlayer
  # Creates a new player and deals him a hand of eight cards.
  def self.deal_player_in(deck)
    AIPlayer.new(deck.take(8))
  end

  attr_reader :cards  

  def initialize(cards)
    @cards = cards
  end

  # Returns the suit the player has the most of; this is the suit to
  # switch to if player gains control via eight.
  def favorite_suit
    suit_count = Hash.new { |hash, key| hash[key] = 0 }
    @cards.each do |card|
      suit_count[card.suit] += 1
    end
    suit_count.sort_by {|key, val| val}.last[0]

  end

  # Plays a card from hand to the pile, removing it from the hand.
  def play_card(pile, card)
    raise ArgumentError.new "cannot play card outside your hand" unless @cards.include?(card)
    if card.value == :eight
      pile.play_eight(card, favorite_suit)
    else
      pile.play(card)
    end
    @cards.delete(card)
  end

  # Draw a card from the deck into player's hand.
  def draw_from(deck)
    @cards += deck.take(1)
  end

  # Choose any valid card from the player's hand to play; prefer non-eights
  # to eights (save those!). Return nil if no possible play.
  def choose_card(pile)
    chose_card = nil
    @cards.each do |card|
      chose_card = card if (card.value != :eight) && pile.valid_play?(card)
    end

    chose_card = @cards.select {|card| card.value == :eight}.first if chose_card.nil?
    chose_card

  end

  # Try to choose a card; if AI has a valid play, play the card. Else, draw
  # from the deck and try again. If deck is empty, pass.
  def play_turn(pile, deck)
    played = false
    while deck.count > 0 && !played
      card = choose_card(pile)

      if !card.nil?
        play_card(pile, card)
        played = true
      else
        draw_from(deck)
      end
    end
  end
end
