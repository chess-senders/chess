class GamesController < ApplicationController
  before_action :authenticate_player!

  def index
    #@games = Game.where('white_player_id != ?', current_player.id)
    @games = Game.where(black_player_id: nil)
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
    if @game.valid? && current_player != @game.white_player
      @game.update(black_player: current_player, state: 1)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def game_params
    params.require(:game).permit(:name)
  end
end
