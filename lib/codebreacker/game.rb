
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

    def answer_on(input)
      validate input
      form_an_answer_for input
      @attempts -= 1
      @answer
    end

    def won?
      @answer == '++++'
    end

    private

    def create_code
      (1..4).map { rand(1..6) }.join
    end

    def form_an_answer_for(input)
      input.each_char.with_index do |guess, index|
        if    guess == @secret[index] then  @answer << '+'
        elsif @secret.include? guess  then  @answer << '-'
        end
      end
    end

    def validate(input)
      raise ArgumentError, 'Type only integers from 1 to 6' if input =~ /[^0-6]/
      raise ArgumentError, 'Type exactly 4 integer' unless input.length == 4
    end
  end
end
