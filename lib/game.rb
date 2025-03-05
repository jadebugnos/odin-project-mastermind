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
    puts "Role received: #{role.inspect}"
    run_game(role)
  end

  # this method keeps looping the game for 10 rounds
  def run_game(role)
    display_game_instructions(role)
    secret_code = role == "Code Breaker" ? @computer_secret_code : @player.choose_secret_code
    counter = 12
    loop_game(counter, role, secret_code)
  end

  def display_game_instructions(role)
    instructions = role == "Code Breaker" ? :code_breaker : :code_maker
    @player.slow_print(GAME_INSTRUCTIONS[instructions])
  end

  def loop_game(counter, role, secret_code)
    while counter.positive?
      puts "#{counter} tries left"
      @colors.display_colors
      guess = role == "Code Breaker" ? @player.guess_code : @computer.computer_guess(@hints_history.last, secret_code)
      @hints_history << (if role == "Code Breaker"
                           @computer.computer_feedback(guess,
                                                       secret_code)
                         else
                           @player.player_feedback
                         end)
      @colors.color_and_print(@hints_history.last)
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
end
