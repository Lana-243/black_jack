require_relative 'game'

puts 'Hello, welcome to Blackjack game!'
puts 'Please enter your name!'

name = gets.chomp

puts "Welcome, #{name}!"

game = Game.new(name)
game.start_game

loop do
  puts 'Press Y if you would like to start again'
  puts 'Press any other key if you want to finish'
  answer = gets.chomp
  if (answer == 'Y') || (answer == 'Y')
    game.start_game
  else
    puts "The game is over"
    puts "#{name}, thank you for the game!"
    game.finish_game
    break
  end
end
