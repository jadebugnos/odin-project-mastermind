# this file handles the player class definition
class Player
  attr_accessor :username, :roles

  def initialize(username = nil, role = nil)
    @username = username
    @roles = role
  end

  # handles the player inputs
  def handle_input
    @username = validate_username
    slow_print "Hello #{@username}!"
    @roles = validate_role
    slow_print "You are the #{@roles}"
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

  # add a slow printing animation to texts for better visual
  def slow_print(text)
    text.each_char do |char|
      print char
      sleep(0.05)
    end
    puts
  end
end
