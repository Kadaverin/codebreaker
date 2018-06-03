module Codebreacker
  # Interface for console game 'Codebreacker''
  class GameInterface
    def initialize(game = Game.new)
      @game = game
    end

    def input
      gets.chomp.downcase
    end

    def start_game
      greeting
      play
    end

    def show(smtg)
      puts smtg
    end

    def play
      until @game.attempts.zero?

        case guess = input
        when 'r' then show_rules
        when 'h' then give_a_hint
        else show answer_on guess
        end

        break if @game.won?
      end
      @game.won? ? handle_game_won : handle_game_lost
    end

    def handle_game_won; end

    def handle_game_lost; end

    def show_rules
      puts 'rules'
    end

    def give_a_hint; end

    def answer_on(input)
      @game.answer_on input
    rescue ArgumentError => err
      err.message
    end

    def ask_for_restart
      puts 'restart?'
    end

    def greeting
      puts 'hello'
    end
  end
end
