
module Codebreaker
  RSpec.describe Game do
    let(:game) { Game.new }

    describe '#new_game' do
      before { game.new_game }

      it 'saves secret string with numbers from 1 to 6' do
        expect(game.instance_variable_get(:@secret)).to match(/^[1-6]{4}\z/)
      end

      it 'set attempts_left to Game::ATTEMPTS_AMOUNT' do
        expect(game.attempts_left).to be_eql(Codebreaker::ATTEMPTS_AMOUNT)
      end

      it 'set @answer to an empry string' do
        expect(game.answer).to be_eql('')
      end

      it 'set @history to an empty hash' do
        expect(game.history).to be_eql({})
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

      context '@history' do
        it 'adds @answer to @history hash using user input as a key' do
          user_input = '1234'
          allow(game).to receive(:answer) { '++' }
          game.answer_on(user_input)
          expect(game.history[user_input]).to eql('++')
        end
      end

      context 'Decrements amount of attempts if input is correct' do
        it { expect { game.answer_on('1234') }.to change { game.attempts_left }.by(-1) }
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

    describe '#hint' do
      it 'decrements hitns amount' do
        expect { game.hint }.to change { game.hints_left }.by(-1)
      end

      it { expect(game.hint).to be_instance_of String }

      it 'returns only one character' do
        expect(game.hint.length).to eql(1)
      end

      it 'returns one of secret number if @hints_left != 0' do
        expect(game.instance_variable_get('@secret')).to include game.hint
      end

      it 'returns HO_HINT_LEFT if Game@hints_left = 0' do
        game.instance_variable_set('@hints_left', 0)
        expect(game.hint).to eql(NO_HINTS_LEFT)
      end
    end

    describe '#used_attempts' do
      it 'returns right value' do
        allow(game).to receive(:attempts_left) { 2 }
        expect(game.used_attempts).to be_eql(Codebreaker::ATTEMPTS_AMOUNT - 2)
      end
    end

    describe '#used_hints' do
      it 'returns right value' do
        allow(game).to receive(:hints_left) { 2 }
        expect(game.used_hints).to be_eql(Codebreaker::HINTS_AMOUNT - 2)
      end
    end
  end
end
