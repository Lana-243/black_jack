require_relative 'dealer'
require_relative 'deck'
require_relative 'player'

puts 'Please enter your name'
player_name = gets.chomp
deck = Deck.new
player = Player.new(player_name)
dealer = Dealer.new

def player_hand(player)
  player.cards.join(', ')
end

def dealer_hand(player)
  dealer.cards.join(', ')
end

2.times { player.cards << deck.take_card }
puts "Your cards: #{player_hand(player)}"
2.times { dealer.cards << deck.take_card }
# puts "Dealer's cards: #{(dealer.cards.count.times}"
