
module Codebreaker
  # //
  class Game
    attr_reader :attempts, :answer, :hints, :history

    def initialize
      new_game
    end

    def new_game
      @attempts = ATTEMPTS_AMOUNT
      @secret = create_code
      @history = {}
      @hints = HINTS_AMOUNT
      @answer = ''
    end

    def answer_on(input)
      validate input
      form_an_answer_for input
      @history[input] = @answer
      @attempts -= 1
      @answer
    end

    def won?
      @answer == '++++'
    end

    def hint
      return NO_HINTS_LEFT if @hints.zero?
      @hints -= 1
      @secret[rand(0..3)]
    end

    private

    def create_code
      (1..4).map { rand(1..6) }.join
    end

    def form_an_answer_for(input)
      @answer = ''
      input.each_char.with_index do |guess, index|
        if    guess == @secret[index] then  @answer << '+'
        elsif @secret[index..-1].include? guess then @answer << '-'
        end
      end
    end

    def validate(input)
      raise ArgumentError, 'Type only integers from 1 to 6' if input =~ /[^0-6]/
      raise ArgumentError, 'Type exactly 4 integer' unless input.length == 4
    end
  end
end
