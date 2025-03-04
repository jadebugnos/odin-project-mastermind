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
    puts "start game is running...."
    role = @player.handle_input
    puts "Role received: #{role.inspect}"
    player_secret_code = @player.choose_secret_code
    # secret_code = role == "Code Breaker" ? @computer_secret_code : @player.choose_secret_code
    secret_code = if role == "Code Breaker"
                    @computer_secret_code
                  elsif role == "Code Maker"
                    player_secret_code
                  end
    puts "secret_code received: #{secret_code.inspect}"
    run_game(role, secret_code)
  end

  # this method keeps looping the game for 10 rounds
  def run_game(role, secret_code)
    puts "run_game method is running"
    display_game_instructions(role)
    counter = 10
    loop_game(counter, role, secret_code)
  end

  def display_game_instructions(role)
    p "Role received: #{role.inspect}"
    instructions = role == "Code Breaker" ? :code_breaker : :code_maker
    @player.slow_print(GAME_INSTRUCTIONS[instructions])
  end

  def loop_game(counter, role, secret_code)
    while counter.positive?
      puts "#{counter} tries left"
      @colors.display_colors
      guess = role == "Code Breaker" ? @player.guess_code : @computer.computer_guess(@hints_history.last)
      guess_correct?(guess, secret_code)
      if @hints_history.last.all? { |item| item == :black }
        declare_result(secret_code, role)
        break
      end
      counter -= 1
    end
  end

  def declare_result(secret_code, _role)
    puts "The Secret Code has been decoded! Congratulations"
    @colors.color_and_print(secret_code)
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
