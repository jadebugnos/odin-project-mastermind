require_relative "lib/game"
require_relative "lib/player"
require_relative "lib/computer"
require_relative "lib/color"
require "colorize"
require "pry-byebug"

colors = Color.new
player = Player.new(colors)
computer = Computer.new
new_game = Game.new(player, colors, computer)
new_game.start_game
