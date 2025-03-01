require_relative "color"
# this file handles the Game class definition
class Game
  attr_reader :colors, :computer_code

  def initialize(player, colors)
    @player = player
    @colors = colors
    @computer_secret_code = @colors.generate_color_code
    @hint = []
  end

  def start_game
    @player.handle_input
    run_game
  end

  # this method keeps looping the game for 10 rounds
  def run_game
    @player.slow_print game_instructions
    counter = 10
    10.times do
      puts "#{counter} tries left"
      @colors.display_colors
      guess = guess_code
      guess_correct?(guess, @computer_secret_code)
      counter -= 1
    end
  end

  # stores the game instruction texts
  def game_instructions
    <<~TEXT
      The computer has created the code. Try and break it.
      You have 10 tries. Each guess will return a hint:

      Black: Correct color and placement
      White: Correct color, wrong placement
      Blank: No correct colors or placements.

      choose 4 colors and type their corresponding numbers:
    TEXT
  end

  # handles the players guess code input
  def guess_code
    guesses = []
    until guesses.size == 4
      guess = gets.chomp.to_i
      color = @colors.colors[guess]
      if (1..10).include?(guess)
        guesses.push(color)
        # Convert each symbol to a string, colorize it, and join with spaces
        puts(guesses.map { |item| item.to_s.colorize(item) }.join(" "))
      else
        puts "Invalid input! please select a valid number 1..10"
      end
    end
    guesses
  end

  # compares secret code to the guess code then outputs the hints
  def guess_correct?(guesses, computer_code)
    arr = Array.new(4, "____")
    p computer_code
    computer_code.each.with_index do |code, i|
      guesses.each.with_index do |guess, j|
        unless %i[black white].include?(arr[j]) # makes sure doesn't overwrite previous assignment
          if code == guess && i == j
            arr[j] = :black
          elsif code == guess && j != i
            arr[j] = :white
          end
        end
      end
    end
    @hint.push(arr)
    puts(arr.map { |item| item.to_s.colorize(item) }.join(" ")) # adds color to the item before printing
    arr = []
  end
end
