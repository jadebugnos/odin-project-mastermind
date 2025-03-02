require_relative "color"
# this file handles the Game class definition
class Game
  attr_reader :colors, :computer_secret_code

  def initialize(player, colors)
    @player = player
    @colors = colors
    @computer_secret_code = @colors.generate_color_code
    @hints_history = []
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
  def guess_correct?(guesses, secret_code)
    hints_board = Array.new(4, "____")
    code_counts = secret_code.tally # counts the occurrences of the codes
    p secret_code
    secret_code.each.with_index do |code, i|
      if code == guesses[i]
        hints_board[i] = :black
        code_counts[code] -= 1 if code_counts[code].positive?
      end
    end

    secret_code.each.with_index do |code, i|
      guesses.each.with_index do |guess, j|
        # Check if:
        # - The current position in `hints_board` is NOT already marked as `:black`
        # - The guessed color (`guess`) exists in the secret code (`code`) but is in the wrong position (`j != i`)
        # - There are still remaining occurrences of `guess` that haven't been marked (`code_counts[guess].positive?`)
        if !%i[black].include?(hints_board[j]) && (code == guess && j != i) && code_counts[guess].positive?
          hints_board[j] = :white
          code_counts[guess] -= 1
        end
      end
    end
    @hints_history.push(hints_board)
    puts(hints_board.map { |item| item.to_s.colorize(item) }.join(" ")) # adds color to the item before printing
    hints_board.clear # resets the array
  end
end
