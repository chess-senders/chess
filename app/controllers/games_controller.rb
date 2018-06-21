class GamesController < ApplicationController
  before_action :authenticate_player!

  def index
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
  end

  private

  def game_params
    params.require(:game).permit(:name)
  end
end
