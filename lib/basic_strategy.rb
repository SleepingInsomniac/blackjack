class BasicStrategy < Player
  def get_bet
    return 'l' if @money >= 500
    amount = @money < 10 ? @money : 10
    puts amount
    amount
  end

  def get_play(game)
    up_card = game.house.hand.cards.first
    house_shown = BlackJack.value_for(Deck.new([up_card]))
    own_value = BlackJack.value_for(@hand)

    return case
    when BlackJack.blackjack?(@hand)
      puts 'I have a blackjack!'
      's'
    when house_shown >= 7 && own_value <= 17
      puts "h"
      'h'
    when own_value >= 12 && (4..6).include?(house_shown)
      puts 's'
      's'
    when own_value >= 13 && house_shown <= 3
      puts 's'
      's'
    when own_value >= 17
      puts 's'
      's'
    else
      puts "I don't know what to do"
      'h'
    end
  end
end
