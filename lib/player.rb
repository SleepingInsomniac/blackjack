class Player
  attr_accessor :hand, :money

  def initialize(money = 100)
    @hand = Deck.new
    @money = money
  end

  def bet(amount)
    @money -= amount
    amount
  end

  def draw(deck, draws = 1)
    draws.times { @hand.cards.push deck.draw }
  end

  def discard_all(deck)
    until @hand.cards.empty?
      deck.discard(@hand.draw)
    end
  end
end
