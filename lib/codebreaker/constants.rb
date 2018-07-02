module Codebreaker
  ATTEMPTS_AMOUNT = 8

  HINTS_AMOUNT = 3

  ASK_FOR_RESTART_MESSAGE = "Are you want to play again? Type 'y' if yes'".freeze

  CONGRATULATION_MESSAGE = 'Congratulation! You are true codebreacker !'.freeze

  SUPPORTING_MESSAGE = 'Dont be upset, but you are looser'.freeze

  NO_HINTS_LEFT = 'no hints left'.freeze

  ASK_USER_NAME_MESSAGE = 'Enter your name, please'.freeze

  ASK_FOR_SAVE_RESULT_MESSAGE = 'Save game statistics to log_file? y/n'.freeze

  GAME_RULES =
    "You have #{ATTEMPTS_AMOUNT} attempts and game answers with"               \
    " up to four pluses and minuses        \n "                                \
    "       \n"                                                                \
    " + (plus) indicates an exact match: \n"                                   \
    "   one of the numbers in the guess is the same as one of the numbers  \n" \
    "   in the secret code and in the same position. \n"                       \
    " - (minus) indicates a number match: \n"                                  \
    "   one of the numbers in the guess is the same as one of the numbers  \n" \
    "   in the secret code but in a different position. \n"                    \
    "                            Tips & Tricks                             \n" \
    "HINTS: type 'h' and game will show one  number from code to you       \n" \
    "RULES: if you forget the rules, just enter 'r' "                          \
    .freeze

  GREETING_MESSAGE =
    "#######################################################################\n"\
    "    CODEBREACKER is a logic game in which a code-breaker tries to break\n"\
    " a secret code created by a code-maker. The code-maker creates a secret\n"\
    " code of four numbers between 1 and 6. \n #{GAME_RULES} \n  "             \
    '                              GOOD LUCK!                                ' \
    .freeze
end
