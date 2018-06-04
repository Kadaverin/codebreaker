module Codebreaker
  RSpec.describe GameInterface do
    let(:game_i) { GameInterface.new }

    describe '#start_game' do
      before do
        allow(game_i).to receive(:greeting)
        allow(game_i).to receive(:play)
      end
      after { game_i.start_game }

      it { expect(game_i).to receive(:greeting).with(no_args) }
      it { expect(game_i).to receive(:play).with(no_args) }
    end

    describe '#play' do
      # have to stub @game.won? because of infinit loop
      before do
        allow(game_i.instance_variable_get('@game')).to receive(:won?) { true }
        allow(game_i).to receive(:show)
      end
      after { game_i.play }

      context 'user tries to guess' do
        before { allow(game_i).to receive(:input).and_return('2134') }

        it 'calls #input ' do
          expect(game_i).to receive(:input)
        end

        it 'calls #answer_on ' do
          expect(game_i).to receive(:answer_on).with('2134')
        end

        it 'calls #handle_lost_game when user loses' do
          allow(game_i.instance_variable_get('@game')).to receive(:won?) { false }
          expect(game_i).to receive(:handle_lost_game)
        end

        it 'calls #handle_won_game when user wins' do
          expect(game_i).to receive(:handle_won_game)
        end
      end

      context 'user wants help' do
        it 'calls #give_a_hint when user types "h"' do
          allow(game_i).to receive(:input).and_return('h')
          expect(game_i).to receive(:give_a_hint)
        end

        it 'calls #show_rules when user types "r"' do
          allow(game_i).to receive(:input).and_return('r')
          expect(game_i).to receive(:show_rules)
        end
      end
    end

    describe '#answer_on' do
      it 'calls @game#answer_on' do
        expect(game_i.instance_variable_get('@game'))
          .to receive(:answer_on).with('1234')
        game_i.answer_on('1234')
      end
      it 'returns error message if rescue ArgumentError' do
        allow(game_i.instance_variable_get('@game')).to receive(:answer_on)
          .and_raise(ArgumentError, 'message')
        expect(game_i.answer_on('sdasd')).to be_eql('message')
      end
    end

    describe '#show_rules' do
      it { expect(game_i).to receive(:show).with(GAME_RULES) }
      after { game_i.show_rules }
    end

    describe '#ask_for_restart' do
      before { allow(game_i).to receive(:show) }
      after { game_i.ask_for_restart }

      it { expect(game_i).to receive(:show).with(ASK_FOR_RESTART_MESSAGE) }
      it { expect(game_i).to receive(:input) }

      it 'calls #restart_game if answer is "y"' do
        allow(game_i).to receive(:input).and_return('y')
        expect(game_i).to receive(:restart_game)
      end
    end

    describe '#greeting' do
      it { expect(game_i).to receive(:show).with(GREETING_MESSAGE) }
      after { game_i.greeting }
    end

    describe '#handle_lost_game' do
      it 'show congratulations and #ask_for_restart' do
        expect(game_i).to receive(:show).with(SUPPORTING_MESSAGE).ordered
        expect(game_i).to receive(:ask_for_restart).with(no_args).ordered
        game_i.handle_lost_game
      end
    end

    describe '#handle_won_game' do
      it 'show support and #ask_for_restart ' do
        expect(game_i).to receive(:show).with(CONGRATULATION_MESSAGE).ordered
        expect(game_i).to receive(:ask_for_restart).with(no_args).ordered
        game_i.handle_won_game
      end
    end

    describe '#give_a_hint' do
      it 'calls #show with @game#hint' do
        expect(game_i).to receive(:show)
          .with(game_i.instance_variable_get('@game').hint)
        game_i.give_a_hint
      end
    end

    describe '#restart_game' do
      it 'reset @game and calls #play' do
        expect(game_i.instance_variable_get('@game')).to receive(:new_game).ordered
        expect(game_i).to receive(:play).ordered
        game_i.restart_game
      end
    end
  end
end
