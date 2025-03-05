# This file handles the computer class definition
class Computer
  def initialize(player, colors, role = nil)
    @player = player
    @colors = colors
    @role = role
    @array_of_colors = %i[placeholder red blue green yellow light_red magenta light_blue light_green light_yellow cyan]
    @guess_history = []
  end

  # refactor to give the computer some intelligence in picking guesses based on players feedback
  def computer_guess(hint = nil, player_secret_code)
    arr = generate_secret_code
    puts "The Computer's guess:"
    @colors.color_and_print(arr)
    unless player_secret_code.nil?
      puts "Your Secret Code:"
      @colors.color_and_print(player_secret_code)
    end
    if hint.nil?
      @guess_history << arr
      arr
    else
      intelligent_guess(hint, @guess_history.last, filtered_colors)
    end
  end

  def intelligent_guess(hints, last_guess, colors)
    puts "intelligent_guess has been called..."
    binding.pry
    marked_black = Array.new(4, nil)
    marked_white = Array.new(4, nil)

    hints.each.with_index do |hint, i|
      if hint == :black
        marked_black[i] = last_guess[i]
      elsif hint == :white
        marked_white[i] = last_guess[i]
      end
    end
    return marked_black if marked_black.all?

    shuffled = marked_white.compact.shuffle

    shuffled.push(colors.sample) while shuffled.size < 4

    shuffled
  end

  def generate_secret_code
    # makes sure it doesn't include the placeholder before taking 4 items for the secret code
    available_colors = filtered_colors
    secret_code = []
    4.times do
      secret_code.push(available_colors.sample)
    end
    secret_code
  end

  def filtered_colors
    @array_of_colors.reject { |item| item == :placeholder }
  end

  # compares secret code to the guess code then outputs the hints
  def computer_feedback(guesses, secret_code)
    hints_board = Array.new(4, "____")
    # this is a hash containing the number of occurrences of each code
    code_counts = secret_code.tally
    add_black_pegs(guesses, secret_code, hints_board, code_counts)
    add_white_pegs(guesses, secret_code, hints_board, code_counts)
    hints_board.shuffle
  end

  def add_black_pegs(guesses, secret_code, hints_board, code_counts)
    secret_code.each.with_index do |code, i|
      if code == guesses[i]
        hints_board[i] = :black
        code_counts[code] -= 1 if code_counts[code].positive?
      end
    end
  end

  def add_white_pegs(guesses, secret_code, hints_board, code_counts)
    secret_code.each.with_index do |code, i|
      guesses.each.with_index do |guess, j|
        # Check if:
        # - The current position in `hints_board` is NOT already marked as `:black`
        # - The guessed color (`guess`) exists in the secret code (`code`) but is in the wrong position (`j != i`)
        # - There are still remaining occurrences of `guess` that haven't been marked (`code_counts[guess].positive?`)
        if !%i[black white].include?(hints_board[j]) && (code == guess && j != i) && code_counts[guess].positive?
          hints_board[j] = :white
          code_counts[guess] -= 1
        end
      end
    end
  end
end
