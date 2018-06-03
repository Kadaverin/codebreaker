module Codebreaker
  # Interface for console game 'Codebreacker''
  class GameInterface
    def initialize(game = Game.new)
      @game = game
    end

    def start_game
      greeting
      play
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
      @game.won? ? handle_won_game : handle_lost_game
    end

    def input
      gets.chomp.downcase
    end

    def show(smtg)
      puts smtg
    end

    def handle_won_game
      show CONGRATULATION_MESSAGE
      ask_for_restart
    end

    def handle_lost_game
      show SUPPORTING_MESSAGE
      ask_for_restart
    end

    def show_rules
      show GAME_RULES
    end

    def give_a_hint
      show ' NOT IMPLEMENTED'
    end

    def answer_on(input)
      @game.answer_on input
    rescue ArgumentError => err
      err.message
    end

    def ask_for_restart
      show ASK_FOR_RESTART_MESSAGE
      restart_game if input == 'y'
    end

    def restart_game
      @game.new_game
      play
    end

    def greeting
      show GREETING_MESSAGE
    end
  end
end
