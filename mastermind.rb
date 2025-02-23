require_relative "lib/game"
require_relative "lib/player"
require "colorize"

player = Player.new
new_game = Game.new(player)
new_game.start_game
