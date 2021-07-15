class Deck
  attr_reader :cards
  SUITS = %w(♠ ♥ ♣ ♦)
  RANKS = %w(2 3 4 5 6 7 8 9 10 a k q j)

  def initialize
    @cards = RANKS.product(SUITS)
    @cards = @cards.map{ |card| card = [card[0] + card[1]] }.flatten
    self.shuffle
  end
  
  def shuffle
    @cards.shuffle!
  end
  
  def take_card
    @cards.shift
  end
  
  
end