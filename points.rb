module Points
  
  attr_accessor
  
  NUMBERS = %w(2 3 4 5 6 7 8 9)
  FACES = %w(k q j)
  ACE = 'a'
  ACE_V1 = -1
  ACE_V2 = 11
  WIN = 21
  
  def hand_points(hand)
    @count = 0
    @aces = 0
    hand.each do |card|
      if (card.length < 3) && (NUMBERS.include? card[0])
        @count += card[0].to_i
      elsif (card.length == 3) || (FACES.include? card[0])
        @count += 10
      elsif card[0] = ACE
        @aces += 1
      end
    end
      
    case @aces
      when 1
        one_ace
      when 2
        two_aces
      when 3
        three_aces
    end
    @count
  end

  def one_ace
    if (@count + ACE_V2) > WIN
        @count -= 1
    else
        @count += 10
    end
  end
  
  def two_aces
    if (@count + ACE_V2 + ACE_V2) <= WIN
        @count += ACE_V2*2
    elsif (@count + ACE_V1 + ACE_V2) <= WIN
        @count += ACE_V1 + ACE_V2
    else 
        @count += ACE_V1*2
    end
  end
  
  def three_aces
    @count = ACE_V2 + ACE_V2 + ACE_V1
  end
end