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

def player_hand
  @player.cards.join(', ')
end

def dealer_hand_private
  dealer_hand_private = []
  @dealer.cards.each do |card|
    dealer_hand_private << card.gsub(/./, "*")
  end
  dealer_hand_private.join(', ')
end

def dealer_hand_open
  @dealer.cards.join(', ')
end

def start_game
  #twice?
  add_card(@player)
  add_card(@player)
  player_card_info
  add_card(@dealer)
  add_card(@dealer)
  dealer_card_info
  bank_add
end

def player_card_info
  puts "Your cards: #{player_hand}"
  puts "You have #{hand_points(@player.cards)} points"
end

def dealer_card_info
  puts "Dealer's cards: #{dealer_hand_open}"
  puts "Dealer has #{hand_points(@dealer.cards)} points"
end

def add_card(person)
  person.cards << @deck.take_card
end

def bank_add(bank)
  @player.money -= 10
  @dealer.money -= 10
  @bank += 20
end

def end_game?
  (@player.cards.length == 3) && (@player.cards.length == 3)
end

def player_turn
  if end_game?
    the_end
  else
    player_turn!
  end  
end

def player_turn!
  puts 'Press 1 if you want to stand'
  puts 'Press 2 if you want to hit'
  puts 'Press 3 if you want to finish'
  answer = gets.chomp
  case answer
    when '1'
      dealer_turn
    when '2'
      add_card(@player)
      player_card_info
      dealer_turn
    when '3'
      the_end
    else
    #raise error
  end
  
  def the_end
    puts 'The game is over!'
    player_card_info
    dealer_card_info
  end
  
  def dealer_turn
    if end_game?
      the_end
    else
      dealer_turn!
    end
  end  
  
  def dealer_turn!
    if hand_points(@dealer.cards) >= 17
      player_turn
    else
      add_card(@dealer)
    end
  end

  def bust?(person)
    hand_points(person.cards) > 21
  end
  
  def player_wins?
    
    #recheck
    (bust?(@player) == false) && (hand_points(@player.cards) > hand_points(@dealer.cards))
  end
  
  def dealer_wins?
    (bust?(@dealer) == false) && (hand_points(@dealer.cards) > hand_points(@player.cards))
  end
  def draw?
    (bust?(@dealer) == false) && (hand_points(@dealer.cards) == hand_points(@player.cards))
  end
  

  def winner?
    if  hand_points(@player.cards) == hand_points(@dealer.cards) == 21
      hand_points(@player.cards) > hand_points(@dealer.cards) 
      
    end
  end
end

game = Game.new('Lana')
game.game_process