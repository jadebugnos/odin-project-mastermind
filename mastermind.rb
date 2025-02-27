require_relative "lib/game"
require_relative "lib/player"
require "colorize"

player = Player.new
colors = Color.new
new_game = Game.new(player, colors)
new_game.start_game
