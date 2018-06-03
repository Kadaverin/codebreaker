module Codebreacker
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

        it 'calls #handle_game_lost when user loses' do
          allow(game_i.instance_variable_get('@game')).to receive(:won?) { false }
          expect(game_i).to receive(:handle_game_lost)
        end

        it 'calls #handle_won_game when user wins' do
          expect(game_i).to receive(:handle_game_won)
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
        # game_i.answer_on('sdasd')
      end
    end
  end
end
