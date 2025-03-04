GAME_INSTRUCTIONS = {
  code_breaker: <<~TEXT,
    The computer has created the code. Try and break it.
    You have 10 tries. Each guess will return a hint:

    Black: Correct color and placement
    White: Correct color, wrong placement
    Blank: No correct colors or placements.

    Choose 4 colors and type their corresponding numbers:
  TEXT

  code_maker: <<~TEXT,
    You are the code maker! Choose a secret code of 4 colors.
    The computer will try to guess your code within 10 tries.

    Each round, you will provide hints:
    Black: Correct color and placement
    White: Correct color, wrong placement
    Blank: No correct colors or placements.

    Enter your secret code by typing the corresponding numbers:
  TEXT

  pegs_instructions: <<~TEXT
    Provide feedback to the computer by selecting a peg:

    1. Black: Correct color and placement
    2. White: Correct color, wrong placement
  TEXT
}.freeze
