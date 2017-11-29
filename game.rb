#!/usr/bin/env ruby
$LOAD_PATH.unshift(File.join(__dir__, 'lib'))

require 'card'
require 'deck'
require 'player'
require 'blackjack'

game = BlackJack.new
game.players.push Player.new
game.start
