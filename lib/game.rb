require_relative "color"
# this file handles the Game class definition
class Game
  attr_reader :colors, :computer_code

  def initialize
    @colors = Color.new
    @computer_secret_code = @colors.generate_color_code
  end

  def start_game
    puts "Welcome to Mastermind\nEnter your name:"
  end

  def run_game
    10.times do
    end
  end

  def guess_code
    guess = gets.chomp
  end

  # will refactor later
  def guess_correct?(guesses)
    hint = []
    computer_code.each.with_index do |code, i|
      guesses.each.with_index do |guess, j|
        if code == guess && i == j
          hint.push(:black)
        elsif code == guess && i != j
          hint.push(:white)
        end
      end
    end
    hint
  end
end
