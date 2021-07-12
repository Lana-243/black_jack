class Deck
  attr_reader :cards
  SUITS = %w(♠ ♥ ♣ ♦)
  RANKS = %w(2 3 4 5 6 7 8 9 10 a k q j)
  NUMBERS = %w(2 3 4 5 6 7 8 9)
  FACES = %w(k q j)
  ACE = 'a'
  ACE_v1 = -1
  ACE_V2 = 11
  WIN = 21
  
  def initialize
    @cards = RANKS.product(SUITS)
    @cards = @cards.map{ |card| card = [card[0] + card[1]] }.flatten
    self.shuffle
  end
  
  def shuffle
    @cards.shuffle!
  end
  
  def take_card
    @cards.shift
  end
  
  def hand_points(hand)
  
    count = 0
    aces = 0
    
    hand.each do |card|
      if (card.length < 3) && (NUMBERS.include? card[0])
        count += card[0]
      elsif (card.length == 3) || (FACES.include? card[0])
        count += 10
      elsif card[0] = ACE
        aces += 1
      end
    end
      
    case aces
      when 1
        one_ace(count)
      when 2
        two_aces(count)
      when 3
        three_aces(count)
    end
    
    def one_ace(count)
      if (count + ACE_V2) > WIN
          count -= 1
      else
          count += 10
      end
    end
    
    def two_aces(count)
      if (count + ACE_V2 + ACE_V2) <= WIN
          count += ACE_V2*2
      elsif (count + ACE_v1 + ACE_V2) <= WIN
          count += ACE_v1 + ACE_V2
      else 
          count += ACE_v1*2
      end
    end
    
    def three_aces(count)
      count = ACE_V2 + ACE_V2 + ACE_v1
    end
  end
end