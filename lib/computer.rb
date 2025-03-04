# This file handles the computer class definition
class Computer
  def initialize(player, colors, role = nil)
    @player = player
    @colors = colors
    @role = role
    @array_of_colors = %i[placeholder red blue green yellow light_red magenta light_blue light_green light_yellow cyan]
  end

  def computer_guess(hint = nil)
    arr = generate_secret_code
    puts "The Computer's guess:"
    @colors.color_and_print(arr)
    unless hint.nil?
      puts "Your Secret Code:"
      @colors.color_and_print(hint)
    end
    arr
  end

  def generate_secret_code
    # makes sure it doesn't include the placeholder before taking 4 items for the secret code
    filtered_colors = @array_of_colors.reject { |item| item == :placeholder }
    secret_code = []
    4.times do
      secret_code.push(filtered_colors.sample)
    end
    secret_code
  end
end
