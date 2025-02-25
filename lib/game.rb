require_relative "color"
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
    # run_game
  end

  def run_game
    10.times do
    end
  end

  def guess_code
    gets.chomp
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
