require_relative "lib/game"
require_relative "lib/player"
require_relative "lib/computer"
require_relative "lib/color"
require "colorize"
require "pry-byebug"

# add a restart functionality after each match incase the player wants to redo the game
colors = Color.new
player = Player.new(colors)
computer = Computer.new(player, colors)
new_game = Game.new(player, colors, computer)
new_game.start_game
