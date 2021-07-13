require_relative 'dealer'
require_relative 'deck'
require_relative 'points'
require_relative 'player'

class Game
  
  include Points
    
  def initialize(player_name)
    @deck = Deck.new
    @player = Player.new(player_name)
    @dealer = Dealer.new
    @bank = 0
  end    
  
  def game_process
    start_game
    second_round
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
  @player.cards << @deck.take_card
  @player.cards << @deck.take_card
  puts "Your cards: #{player_hand(@player)}"
  puts "You have #{hand_points(@player.cards)} points"
  2.times { @dealer.cards << @deck.take_card }
  puts "Dealer's cards: #{dealer_hand(@dealer)}"
  bank_add
end

def bank_add(bank)
  @player.money -= 10
  @dealer.money -= 10
  @bank += 20
end

def second_round_player
  puts 'Press 1 if you want to stand'
  puts 'Press 2 if you want to hit'
  puts 'Press 3 if you want to fold'
  answer = gets.chomp
  case answer
    when '1'
      
    when '2'
      
    when '3'
      
    else
    #raise error
  end
end

def bust?(points)
  points <=21
end

def winner?
  if hand_points(@player.cards)
end

game = Game.new('Lana')
game.game_process