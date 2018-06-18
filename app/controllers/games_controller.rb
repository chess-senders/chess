class GamesController < ApplicationController

  before_action :authenticate_player!

  def index
  end

  def new
  end

  def create
    @black_player = Player.find_by email: params[:opponent_email]
    @game = Game.create({white_player: current_player, black_player: @black_player})
    redirect_to game_path(@game)
  end

  def show
    @game = Game.find(params[:id])
  end

  def update
  end

  private

end