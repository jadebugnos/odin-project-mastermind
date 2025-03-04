# This file handles the computer class definition
class Computer
  def initialize(role = nil)
    @role = role
    @colors = %i[placeholder red blue green yellow light_red magenta light_blue light_green light_yellow cyan]
  end

  def computer_guess(_hint = nil)
    generate_secret_code
  end

  def generate_secret_code
    # makes sure it doesn't include the placeholder before taking 4 items for the secret code
    filtered_colors = @colors.reject { |item| item == :placeholder }
    secret_code = []
    4.times do
      secret_code.push(filtered_colors.sample)
    end
    secret_code
  end
end
