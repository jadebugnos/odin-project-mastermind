# this file handles the player class definition
class Player
  attr_accessor :username, :roles

  def initialize(username = nil, role = nil)
    @username = username
    @roles = role
  end

  def handle_input
    @username = validate_username
    @roles = validate_role
    puts @roles
  end

  def validate_username
    puts "Welcome to Mastermind\nEnter your username:"
    loop do
      username = gets.chomp
      return username unless username.nil? || username.strip.empty?

      puts "Error: Username cannot be empty"
    end
  end

  def validate_role
    role = nil
    loop do
      puts "choose your role:\nEnter 1 for Code Breaker\nEnter 2 for Code Maker"
      role = gets.chomp.to_i

      raise "Unexpected error: role was not set!" unless [1, 2].include?(role)

      break
    rescue StandardError => e
      puts e.message
    end
    role == 1 ? "Code Breaker" : "Code Maker"
  end
end
