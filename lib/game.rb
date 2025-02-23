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
    puts "Welcome to Mastermind\nEnter your name:"
    username = gets.chomp
    puts "Do you want to be the code breaker or the code maker?\nType your choice:"
    role = gets.chomp
    @player.set_info(username, role)
    run_game
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

# guesses.each.with_index do |guess, j|
#   if code == guess && i == j
#     @hint.push(:black)
#   elsif code == guess && i != j
#     @hint.push(:white)
#   end
# end
