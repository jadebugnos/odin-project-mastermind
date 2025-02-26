require "colorize"
# this file defines the Color class
class Color
  attr_reader :colors

  def initialize
    @colors = %i[placeholder red blue green yellow light_red magenta light_blue light_green light_yellow cyan]

  end

  def generate_color_code
    colors.sample(4)
  end

  def display_colors
    @colors.each_with_index do |item, index|
      if index == @colors.length - 1
        puts "#{index}. #{item}\n".colorize(item)
      elsif !index.zero?
        print "#{index}. #{item} ".colorize(item)
      end
    end
  end
end
