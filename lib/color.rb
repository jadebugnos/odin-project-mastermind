require "colorize"
# this file defines the Color class
class Color
  attr_reader :colors

  def initialize
    @colors = %i[red blue green yellow orange purple black white gray pink]
  end

  def generate_color_code
    colors.sample(4)
  end
end
