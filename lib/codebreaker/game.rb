
module Codebreaker
  # //
  class Game
    attr_reader :attempts_left, :answer, :hints_left, :history

    def initialize
      new_game
    end

    def new_game
      @secret = create_code
      @history = {}
      @answer = ''
      @hints_left = HINTS_AMOUNT
      @attempts_left = ATTEMPTS_AMOUNT
    end

    def answer_on(input)
      @answer = ''
      validate input
      form_an_answer_for input
      @history[input] = answer
      @attempts_left -= 1
      answer
    end

    def won?
      @answer == '++++'
    end

    def hint
      return NO_HINTS_LEFT if @hints_left.zero?
      @hints_left -= 1
      @secret[rand(0..3)]
    end

    def used_attempts
      ATTEMPTS_AMOUNT - attempts_left
    end

    def used_hints
      HINTS_AMOUNT - hints_left
    end

    private

    def create_code
      (1..4).map { rand(1..6) }.join
    end

    def form_an_answer_for(input)
      temp = @secret.clone
      input.each_char.with_index do |guess, index|
        if guess == @secret[index]
          @answer << '+'
          temp[index] = 'x'  # fake value
          input[index] = 'y' # another fake value
        end
      end
      # this fake values will never intersect, so we can do this
      @answer << '-' * (temp.chars & input.chars).length
    end

    def validate(input)
      raise ArgumentError, 'Type only integers from 1 to 6' if input =~ /[^0-6]/
      raise ArgumentError, 'Type exactly 4 integer' unless input.length == 4
    end
  end
end
