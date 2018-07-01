module Codebreaker
  # Interface for console game 'Codebreacker''
  class GameInterface
    def initialize(game = Game.new, path_to_log_file = './log_file')
      @game = game
      @path = path_to_log_file
    end

    def start_game
      greeting
      play
    end

    def play
      until @game.attempts_left.zero?

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

    def final_interact_with_user
      ask_for_save_result
      ask_for_restart
    end

    def handle_won_game
      show CONGRATULATION_MESSAGE
      final_interact_with_user
    end

    def handle_lost_game
      show SUPPORTING_MESSAGE
      final_interact_with_user
    end

    def show_rules
      show GAME_RULES
    end

    def give_a_hint
      show @game.hint
    end

    def answer_on(input)
      @game.answer_on input
      @game.history
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

    def ask_for_save_result
      show ASK_FOR_SAVE_RESULT_MESSAGE
      save_result if input == 'y'
    end

    def save_result
      user = ask_user_name
      File.open(@path, 'a') do |f|
        f.puts game_statistics_for user
      end
    end

    def ask_user_name
      show ASK_USER_NAME_MESSAGE
      input.capitalize
    end

    def game_statistics_for(user_name)
      status = @game.attempts_left.zero? ? 'Looser' : 'Winner'

      "User name : #{user_name} \n" \
      "Game status: #{status} \n" \
      "Used hints: #{@game.used_hints} \n" \
      "Used attempts: #{@game.used_attempts} \n"\
      "_________________________________________________\n"
    end
  end
end
