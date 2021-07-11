class Player
  
  attr_reader :name, :money, :cards
  
  def initialize(name)
    @name = name
    @money = 100
    @cards = []
  end
  
  def money
  end
end