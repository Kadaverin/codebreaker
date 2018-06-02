
module Codebreacker
  RSpec.describe Game do
    let(:game) { Game.new }

    describe '#new_game' do
      before { game.new_game }

      it 'saves secret string with numbers from 1 to 6' do
        expect(game.instance_variable_get(:@secret)).to match(/^[1-6]{4}\z/)
      end

      it 'set attempts to Game::ATTEMPTS_AMOUNT' do
        expect(game.attempts).to eql(Game::ATTEMPTS_AMOUNT)
      end
    end

    describe '#answer_on' do
      before { game.instance_variable_set('@secret', '1234') }

      context 'validates user input' do
        it 'calls #validate' do
          expect(game).to receive(:validate).with('1234')
          game.answer_on('1234')
        end

        it "raise error if input isn't a digits" do
          expect { game.answer_on('sdfsdf') }.to raise_error(ArgumentError)
        end

        it 'raise error if nums are not from 1 to 6' do
          expect { game.answer_on('1267') }.to raise_error(ArgumentError)
        end

        it 'raise error if input size is less than 4' do
          expect { game.answer_on('126') }.to raise_error(ArgumentError)
        end
      end

      context 'Decrements amount of attempts if input is correct' do
        it { expect { game.answer_on('1234') }.to change { game.attempts }.by(-1) }
      end

      context "gives right answers on user's input" do
        it '"++++"  when user guess secret' do
          expect(game.answer_on('1234')).to eql('++++')
        end

        it '"+"  when user guess only one digit exactly' do
          expect(game.answer_on('1565')).to eql('+')
        end

        it '"----"  when user guess all nums but in wrong order' do
          expect(game.answer_on('4321')).to eql('----')
        end

        it '"+-"  when user guess second num exactly and third nearly' do
          expect(game.answer_on('6246')).to eql('+-')
        end

        it 'empty when user is wrong absolutely' do
          expect(game.answer_on('6656')).to eql('')
        end
      end
    end
    describe '#won' do
      it 'returns true if answer is "++++" ' do
        game.instance_variable_set('@answer', '++++')
        expect(game).to be_won
      end

      it 'returns false if answer is wrong' do
        expect(game).not_to be_won
      end
    end
  end
end
