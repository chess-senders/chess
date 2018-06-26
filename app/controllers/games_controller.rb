class GamesController < ApplicationController
  before_action :authenticate_player!

  def index
    @games = Game.all
  end

  def new
    @game = Game.new
  end

  def create
    @game = Game.create(game_params.merge(white_player: current_player))
    if @game.valid?
      redirect_to game_path(@game)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @game = Game.find(params[:id])
  end

  def update
    @game = Game.find(params[:id])
    if @game.white_player != current_player
      @game.update(black_player: current_player, state: 1)
      redirect_to game_path(@game)
    else
      flash.alert = 'You are already in this game'
      redirect_to games_path
    end
  end

  private

  def game_params
    params.require(:game).permit(:name)
  end
end
