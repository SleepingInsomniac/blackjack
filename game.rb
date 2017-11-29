#!/usr/bin/env ruby
$LOAD_PATH.unshift(File.join(__dir__, 'lib'))

require 'card'
require 'deck'
require 'player'
require 'blackjack'
require 'basic_strategy'

game = BlackJack.new
game.players.push Player.new
game.players.push BasicStrategy.new
game.start
