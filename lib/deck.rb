class Deck
  def self.standard
    values = %w[2 3 4 5 6 7 8 9 10 J Q K A]
    suits = %w[♦ ♣ ♥ ♠]
    deck = new
    suits.each do |s|
      values.each do |v|
        deck.cards.push Card.new(s, v)
      end
    end
    deck
  end

  attr_accessor :cards, :discard

  def initialize
    @cards = []
    @discard = []
  end

  def combine(deck)
    @cards.concat deck.cards
    self
  end

  def draw
    recombine if @cards.empty?
    card = @cards.pop
    # puts "Draw #{card}"
    card
  end

  def shuffle(count = 10)
    puts "Shuffling..."
    count.times { @cards.shuffle! }
    self
  end

  def recombine
    puts "Recombine..."
    @cards.concat @discard
    @discard = []
    shuffle
  end

  def discard(card)
    @discard.push card
  end

  def has?(value)
    @cards.map(&:value).any? {|v| v == value}
  end

  def has_any?(values)
    values.any? { |v| has?(v) }
  end

  def has_suit?(suit)
    @cards.map(&:suit).any? {|s| s == suit}
  end

  def to_s
    "[#{cards.join(' ')}]"
  end
end
