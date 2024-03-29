require_relative 'dealer'
require_relative 'deck'
require_relative 'points'
require_relative 'player'
require_relative 'validation'
require_relative 'decorations'

class Game
  include Points
  include Validation
  include Decorations

  attr_accessor :deck, :player, :dealer, :bank, :result, :answer

  validate :answer, :presence

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

  def player_money_info
    puts "You have #{@player.money}$ in your pocket"
  end

  def dealer_money_info
    puts "Dealer has #{@dealer.money}$ in their pocket"
  end

  def dealer_private_info
    dealer_hand_private = []
    @dealer.cards.each do
      dealer_hand_private << '**'
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
    two_lines
    puts 'Press 1 if you want to stand'
    puts 'Press 2 if you want to hit'
    puts 'Press 3 if you want to finish'
    @answer = gets.chomp
    validate!
    case @answer
    when '1'
      dealer_turn
    when '2'
      add_card(@player)
      dealer_turn
    when '3'
      the_end
    end
  end

  def dealer_turn!
    line
    add_card(@dealer) if hand_points(@dealer.cards) >= 17
    player_card_info
    dealer_card_private_info
    player_turn
  end

  def bust?(person)
    hand_points(person.cards) > 21
  end

  def still_playing?(person)
    !bust?(person)
  end

  def winner_exists?
    still_playing?(@player) || still_playing?(@dealer)
  end

  def game_result
    result?
    result!
  end

  def player_wins?
    ((hand_points(@player.cards) > hand_points(@dealer.cards)) &&
    still_playing?(@player)) || bust?(@dealer)
  end

  def dealer_wins?
    ((hand_points(@dealer.cards) > hand_points(@player.cards)) &&
    still_playing?(@dealer)) || bust?(@player)
  end

  def draw?
    hand_points(@player.cards) == hand_points(@dealer.cards)
  end

  def result?
    if winner_exists?
      if player_wins?
        @result = :player_wins
      elsif dealer_wins?
        @result = :dealer_wins
      elsif draw?
        @result = :draw
      end
    else
      @result = :no_winner
    end
  end

  def result!
    case @result
    when :player_wins
      @player.money += @bank
      puts 'You win!'
    when :dealer_wins
      @dealer.money += @bank
      puts 'Dealer wins!'
    when :draw
      @player.money += 10
      @dealer.money += 10
      puts 'It is a draw!'
    when :no_winner
      puts 'There is no winner'
    end
  end

  def money_left?
    (@player.money >= 10) && (@dealer.money >= 10)
  end

  def game_process
    start_game
    player_turn
  end

  def start_game
    if money_left?
      @player.cards = []
      @dealer.cards = []
      2.times { add_card(@player) }
      2.times { add_card(@dealer) }
      line
      player_card_info
      line
      dealer_card_private_info
      bank_add
      player_turn
    else
      the_end
    end
  end

  def player_turn
    if end_game? || three_cards?(@player)
      the_end
    else
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
    line
    puts 'Round is over!'
    line
    player_card_info
    line
    dealer_card_info
    line
    game_result
    line
    player_money_info
    line
    dealer_money_info
  end

  def finish_game
    player_money_info
  end
end
