
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

      context 'validate user input' do
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

        it '"+-"  when user gues second num exactly and third nearly' do
          expect(game.answer_on('6246')).to eql('+-')
        end
      end
    end
    # describe '#answer_on'"#answer_on" do
    #   let(:input) { '1234' }

    #   it "calls validate with params '1234' " do
    #     expect(subject).to receive(:validate).with('1234')
    #     game.answer_on(input)
    #   end
    # end
  end
end
