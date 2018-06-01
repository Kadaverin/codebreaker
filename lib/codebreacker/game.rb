
module Codebreacker
  # //
  class Game
    ATTEMPTS_AMOUNT = 8
    attr_reader :attempts, :answer

    def initialize
      new_game
    end

    def new_game
      @attempts = ATTEMPTS_AMOUNT
      @secret = create_code
      @answer = ''
    end

    private def create_code
      (1..4).map { rand(1..6) }.join
    end

    def answer_on(input)
      validate input
      form_an_answer_for input
      @answer
    end

    private def form_an_answer_for(input)
      input.each_char.with_index do |guess, index|
        if    guess == @secret[index] then  @answer << '+'
        elsif @secret.include? guess  then  @answer << '-'
        end
      end
    end

    private def validate(input)
      raise ArgumentError, 'Type only numbers from 1 to 6' if input =~ /[^0-6]/
      raise ArgumentError, 'Type exactly 4 integer' unless input.length == 4
    end

    # def count_exactly_right(input)
    #   input.each_char.with_index do |guess, i|
    #     answer << '+' if guess == secret[i]
    #   end
    # end

    # def count_nearly_right(input)
    #   input.each_char.with_index do |guess, i|
    #     if  && guess != secret[i]
    #   end
    # end
  end
end
