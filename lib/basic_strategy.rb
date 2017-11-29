class BasicStrategy < Player
  def get_bet
    'l' if rounds_played >= 30
    amount = @money < 10 ? @money : 10
    puts amount
    amount
  end

  def get_play(game)
    up_card = game.house.hand.cards.first
    house_shown = BlackJack.value_for(Deck.new([up_card]))
    own_value = BlackJack.value_for(@hand)
    return 's' if BlackJack.blackjack?(@hand)
    return 'h' if house_shown >= 7 && own_value <= 17
    return 's' if own_value >= 12 && (4..6).include?(house_shown)
    return 's' if own_value >= 13 && house_shown <= 3
    return 'h'
  end
end
