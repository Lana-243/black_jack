require_relative 'dealer'
require_relative 'deck'
require_relative 'player'
require_relative 'game'

puts 'Please enter your name'
player_name = gets.chomp
game = Game.new(player_name)
