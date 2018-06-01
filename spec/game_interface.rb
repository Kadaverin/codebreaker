module Codebreacker
  class GameInterface
    def initialize
      @game = Game.new
    end

    def input
      gets.chomp.downcase
    end
  end
end
