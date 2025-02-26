require_relative "color"
require "colorize"
# this file handles the Game class definition
class Game
  attr_reader :colors, :computer_code

  def initialize(player)
    @player = player
    @colors = Color.new
    @computer_secret_code = @colors.generate_color_code
    @hint = []
  end

  def start_game
    @player.handle_input
    run_game
  end

  # add logic to run game, this is what you should do next
  def run_game
    game_instructions
    counter = 10
    10.times do
      puts "#{counter} tries left"
      @colors.display_colors
      guess = guess_code
      guess_correct?(guess)
      puts @hint
      counter -= 1
    end
  end

  # display game instructions
  def game_instructions
    puts "\n" * 5 # Adds 5 new lines for spacing
    puts <<~TEXT
      The computer has created the code. Try and break it.
      You have 10 tries. Each guess will return a hint:

      Black: Correct color and placement
      White: Correct color, wrong placement
      Blank: No correct colors or placements.

      choose 4 colors and type their corresponding numbers:
    TEXT
  end

  def guess_code
    guesses = []

    until guesses.size == 4
      guess = gets.chomp.to_i
      if (1..10).include?(guess)
        guesses.push(@colors.colors[guess].to_s.colorize(@colors.colors[guess]))
        puts guesses.join(" ")
      else
        puts "Invalid input! please select a valid number 1..10"
      end
    end
    guesses
  end

  # will refactor later
  def guess_correct?(guesses)
    arr = []
    @computer_secret_code.each.with_index do |code, i|
      if code == guesses[i] && i == guesses.index(guesses[i])
        arr.push(:black)
      elsif code == guesses[i] && i != guesses.index(guesses[i])
        arr.push(:white)
      end
    end
    @hint.push(arr)
    arr
  end
end
