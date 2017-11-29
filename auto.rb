#!/usr/bin/env ruby
$LOAD_PATH.unshift(File.join(__dir__, 'lib'))

require 'card'
require 'deck'
require 'player'
require 'blackjack'
require 'basic_strategy'

game = BlackJack.new
5.times { game.players.push BasicStrategy.new(500, 600) }
game.start
