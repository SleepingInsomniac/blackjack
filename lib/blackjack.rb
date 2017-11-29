class BlackJack
  BET_MIN = 5

  attr_accessor :deck, :house, :players

  def initialize(decks = 6)
    @deck = Deck.new
    decks.times { deck.combine Deck.standard }
    deck.shuffle
    @house = Player.new(0)
    @players = []
  end

  def empty_hands
    [*@players, @house].each do |person|
      person.discard_all(@deck)
    end
  end

  def remove_deadbeats
    @players.delete_if.with_index do |player, i|
      if player.money < BET_MIN
        puts "Player ##{i+1} has no more money"
        true
      else
        false
      end
    end
  end

  def accept_bets
    @bets = {}
    @players.each.with_index do |player, i|
      amount = 0
      until amount >= BET_MIN && amount <= player.money
        print "Player ##{i+1} (min #{BET_MIN}) (#{player.money}): "
        amount = gets.chomp.to_i
      end
      @bets[player] = player.bet(amount)
      @house.money += amount
    end
  end

  def deal
    2.times do
      [*@players, @house].each { |player| player.draw(@deck) }
    end
  end

  def table
    puts <<~TABLE
      House: #{@house.hand.cards.first} [??]
      Players: #{@players.map { |p| p.hand.to_s }.join('  ')}
    TABLE
  end

  def value_for(hand)
    total = 0
    hand.cards.each do |card|
      value = card.value.to_i
      value = 1 if card.value == 'A'
      total += value == 0 ? 10 : value
    end
    total += 10 if hand.has?('A') && total <= 11
    total
  end

  def play
    @players.each.with_index do |player, i|
      puts "Player ##{i+1}:"
      complete = false
      until complete
        print "#{player.hand} (#{value_for(player.hand)}): "
        action = gets.chomp
        case action
        when 'h'
          player.draw(@deck)
          puts "#{player.hand.cards.last} (#{value_for(player.hand)})"
        when 's'
          complete = true
        end
        if value_for(player.hand) > 21
          puts "Bust!"
          complete = true
        end
      end
    end
  end

  def house_play
    puts "House: #{@house.hand} (#{value_for(@house.hand)})"
    while value_for(@house.hand) < 17
      @house.draw(@deck)
      puts "House: #{@house.hand} (#{value_for(@house.hand)})"
    end
  end

  def blackjack?(hand)
    value = value_for(hand)
    value == 21 && hand.count = 2 && hand.has?('A') && hand.has_any?(%w[10 J Q K])
  end

  def bust?(hand)
    value_for(hand) > 21
  end

  def evaluate
    puts
    @players.each.with_index do |player, i|
      print "Player ##{i+1}: "

      if bust?(player.hand)
        puts "Bust.."
        next
      end

      if blackjack?(player.hand)
        if blackjack?(@house.hand)
          puts "Push"
          player.money += @bets[player]
          @house.money -= @bets[player]
        else
          puts "Blackjack!"
          player.money += @bets[player] * 2.5
          @house.money -= @bets[player] * 2.5
        end
        next
      end

      if bust?(@house.hand)
        puts "House busts!"
        player.money += @bets[player] * 2
        @house.money -= @bets[player] * 2
        next
      end

      if value_for(@house.hand) == value_for(player.hand)
        puts "Push"
        player.money += @bets[player]
        @house.money -= @bets[player]
        next
      end

      if value_for(@house.hand) < value_for(player.hand)
        puts "Win!"
        player.money += @bets[player] * 2
        @house.money -= @bets[player] * 2
      else
        puts "Lose!"
      end
    end
  end

  # ===================

  def hand
    empty_hands
    puts "\nBets:"
    accept_bets
    puts "\nDeal:"
    deal
    puts table
    play
    house_play
    evaluate
    puts "House has: $#{@house.money}"
    @players.each.with_index do |p,i|
      puts "Player ##{i+1} has: $#{p.money}"
    end
  end

  def start
    loop do
      remove_deadbeats
      break if @players.count <= 0
      hand
    end
  end
end
