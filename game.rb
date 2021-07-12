require_relative 'dealer'
require_relative 'deck'
require_relative 'player'

class Game
    
  def initialize(player_name)
    @deck = Deck.new
    @player = Player.new(player_name)
    @dealer = Dealer.new
  end    
  
  def game_process
    start_game
    
  end

def player_hand(player)
  @player.cards.join(', ')
end

def dealer_hand(dealer)
  dealer_hand_private = []
  dealer.cards.each do |card|
    dealer_hand_private << card.gsub(/./, "*")
  end
  dealer_hand_private.join(', ')
end

def start_game
  2.times { @player.cards << deck.take_card }
  puts "Your cards: #{player_hand(@player)}"
  2.times { @dealer.cards << deck.take_card }
  puts "Dealer's cards: #{dealer_hand(@dealer)}"
end

end