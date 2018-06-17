class GamesController < ApplicationController
  def index
    @games = Games.where(state: 'Waiting for players')
  end

  def new
    @game = Game.new
  end

  def create
    @game = Game.create
  end

  def show
  end

  def update
  end

end
