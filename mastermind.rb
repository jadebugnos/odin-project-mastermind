require_relative "lib/game"
require_relative "lib/player"
require "colorize"

new_game = Game.new
new_game.start_game
username = gets.chomp
puts "Do you want to be the code breaker or the code maker?\nType your choice:"
role = gets.chomp
player = Player.new(username, role)
puts player.username
puts player.role
