module Games
  class UpdateState < ApplicationService
    attr_reader :game

    def initialize(game)
      @game = game
    end

    def call
      return game.update(state: 2) if game.state == "White's Turn"
      return game.update(state: 1) if game.state == "Black's Turn"
    end
  end
end
