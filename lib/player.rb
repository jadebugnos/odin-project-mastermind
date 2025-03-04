require_relative "instructions"
# this file handles the player class definition
class Player
  attr_accessor :username, :roles

  def initialize(colors, username = nil, role = nil)
    @colors = colors
    @username = username
    @roles = role
  end

  # handles the player inputs
  def handle_input
    @username = validate_username
    slow_print "Hello #{@username}!"
    @roles = validate_role
    slow_print "You are the #{@roles}"
    @roles
  end

  # handles player input validation for username
  def validate_username
    slow_print "Welcome to Mastermind\nEnter your username:\n"
    loop do
      username = gets.chomp
      return username unless username.nil? || username.strip.empty?

      puts "Error: Username cannot be empty"
    end
  end

  # handle player input validation for the role
  def validate_role
    role = nil
    loop do
      slow_print "Please choose your role:\nEnter 1 for Code Breaker\nEnter 2 for Code Maker\n"
      role = gets.chomp.to_i

      raise "Unexpected error: role was not set!" unless [1, 2].include?(role)

      break
    rescue StandardError => e
      puts e.message
    end
    role == 1 ? "Code Breaker" : "Code Maker"
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
        @colors.color_and_print(guesses)
      else
        puts "Invalid input! please select a valid number 1..10"
      end
    end
    guesses
  end

  def choose_secret_code
    @colors.display_colors
    guess_code
  end

  # add a slow printing animation to texts for better visual
  def slow_print(text)
    text.each_char do |char|
      print char
      sleep(0.05)
    end
    puts
  end

  def give_hints
    hints = []
    pegs = %i[placeholder black white]
    slow_print(GAME_INSTRUCTIONS[:pegs_instructions])
    until hints.size == 4
      hint = gets.chomp.to_i
      if (1..2).include?(hint)
        hints.push(pegs[hint])
        # Convert each symbol to a string, colorize it, and join with spaces
        @colors.color_and_print(hints)
      else
        puts "Invalid input! please select a valid number 1..10"
      end
    end
    hints
  end
end
