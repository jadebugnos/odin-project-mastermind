require_relative "color"
require_relative "instructions"
# this file handles the Game class definition
class Game
  attr_reader :colors, :computer_secret_code

  def initialize(player, colors, computer)
    @player = player
    @colors = colors
    @computer = computer
    @computer_secret_code = @computer.generate_secret_code
    @hints_history = []
  end

  def start_game
    role = @player.handle_input
    run_game(role)
  end

  # this method keeps looping the game for 10 rounds
  def run_game(role)
    display_game_instructions(role)
    counter = 10
    loop_game(counter, role)
  end

  def display_game_instructions(role)
    if role == "Code Breaker"
      @player.slow_print(GAME_INSTRUCTIONS[:code_breaker])
    else
      @player.slow_print(GAME_INSTRUCTIONS[:code_maker])
    end
  end

  def loop_game(counter, role)
    while counter
      puts "#{counter} tries left"
      @colors.display_colors
      guess = @player.guess_code
      guess_correct?(guess, @computer_secret_code)
      if @hints_history.last.all? { |item| item == :black }
        puts "The Secret Code has been decoded! Congratulations"
        role == "Code Breaker" ? @colors.color_and_print(computer_secret_code) : @colors.color_and_print()
        break
      end
      counter -= 1
    end
  end

  # compares secret code to the guess code then outputs the hints
  def guess_correct?(guesses, secret_code)
    hints_board = Array.new(4, "____")
    # this is a hash containing the number of occurrences of each code
    code_counts = secret_code.tally
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
        if !%i[black white].include?(hints_board[j]) && (code == guess && j != i) && code_counts[guess].positive?
          hints_board[j] = :white
          code_counts[guess] -= 1
        end
      end
    end
    @hints_history.push(hints_board)
    @colors.color_and_print(hints_board)
    hints_board = []
  end
end
