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
    @result = nil
  end    
  
  def view_hand(person)
    person.cards.join(', ')
  end
  
  def player_card_info
    puts "Your cards: #{view_hand(@player)}"
    puts "You have #{hand_points(@player.cards)} points"
  end
  
  def dealer_card_info
    puts "Dealer's cards: #{view_hand(@dealer)}"
    puts "Dealer has #{hand_points(@dealer.cards)} points"
  end
  
  def dealer_card_private_info
    puts "Dealer's cards: #{dealer_private_info}"
  end
  
  def dealer_private_info
    dealer_hand_private = []
    @dealer.cards.each do |card|
      dealer_hand_private << card.gsub(/./, "*")
    end
     dealer_hand_private.join(', ')
  end
  
  def add_card(person)
    person.cards << @deck.take_card
  end
  
  def bank_add
    @player.money -= 10
    @dealer.money -= 10
    @bank += 20
  end
  
  def three_cards?(person)
    person.cards.length == 3
  end
  
  def end_game?
    three_cards?(@player) && three_cards?(@dealer)
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
        dealer_turn
      when '3'
        the_end
      else
      #raise error
    end
  end
  
  def dealer_turn!
    puts hand_points(@dealer.cards)
    if hand_points(@dealer.cards) >= 17
      dealer_card_private_info
      player_turn
    else
      add_card(@dealer)
      dealer_card_private_info
      player_turn
    end
  end
  
  def bust?(person)
    hand_points(person.cards) > 21
  end
  
  def still_playing?(person)
    !bust?(person)
  end
  
  def winner_exists?
    still_playing?(@player) && still_playing?(@dealer)
  end
  
  def result?
    if winner_exists?
      if hand_points(@player.cards) > hand_points(@dealer.cards)
        @result = :player_wins
      elsif hand_points(@player.cards) < hand_points(@dealer.cards)
        @result = :dealer_wins
      elsif hand_points(@player.cards) == hand_points(@dealer.cards)
        @result = :draw
      end
    else
      @result = :no_winner
    end
  end
  
  def result
    case @result
      when :player_wins
        @player.money += @bank
        puts 'Player wins!'
        puts "Player has #{@player.money}$"
      when :dealer_wins
        @dealer.money += @bank
        puts 'Dealer wins!'
      when :draw
        puts 'It is a draw!'
      when :no_winner
        puts 'There is no winner'
    end
    
  end
  
  def money_left?
    (@player.money) >= 10 && (@dealer.money >= 10)
  end
  
  def game_process
    start_game
    player_turn
  end

  def start_game
    #twice?
    if money_left?
      2.times { add_card(@player) }
      player_card_info
      2.times { add_card(@dealer) }
      dealer_card_private_info
      bank_add
      player_turn
    else
      the_end
    end
  end
  
  def player_turn
    if end_game?
      the_end
    elsif 
      #change if two cards already
      three_cards?(@player) == false
      player_turn!
    end  
  end
  
  def dealer_turn
    if end_game?
      the_end
    elsif three_cards?(@dealer)
      player_turn
    else
      dealer_turn!
    end
  end  
  
  def the_end
    puts 'The game is over!'
    player_card_info
    dealer_card_info
    puts @result
    result
    
  end
  
end

game = Game.new('Lana')
game.start_game