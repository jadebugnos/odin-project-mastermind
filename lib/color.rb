# this file defines the Color class
class Color
  attr_reader :colors

  def initialize
    # the placeholder is so we won't go out of bounce since index starts at zero
    @colors = %i[placeholder red blue green yellow light_red magenta light_blue light_green light_yellow cyan]
  end

  # handles color printing logic
  def display_colors
    @colors.each_with_index do |item, index|
      if index == @colors.length - 1
        puts "#{index}. #{item}\n".colorize(item)
      elsif !index.zero?
        print "#{index}. #{item} ".colorize(item)
      end
    end
  end

  def color_and_print(codes)
    puts(codes.map { |code| code.to_s.colorize(code) }.join(" "))
  end
end
