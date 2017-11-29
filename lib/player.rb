class Player
  attr_accessor :hand, :money, :stats

  def initialize(money = 100)
    @hand = Deck.new
    @money = money
    @stats = {
      max: @money,
      max_at: 0,
      wins: 0,
      loses: 0
    }
  end

  def bet(amount)
    if @money > @stats[:max]
      @stats[:max] = @money
      @stats[:max_at] = rounds_played
    end
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

  def get_bet
    gets.chomp.to_i
  end

  def get_play(game = nil)
    gets.chomp
  end

  def rounds_played
    @stats[:wins] + @stats[:loses]
  end

  def win_rate
    (@stats[:wins].to_f / rounds_played.to_f) * 100
  end
end
