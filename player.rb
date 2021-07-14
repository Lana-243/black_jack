class Player
  
  attr_reader :name
  attr_accessor :money, :cards
  
  def initialize(name)
    @name = name
    @money = 100
    @cards = []
  end
  
end