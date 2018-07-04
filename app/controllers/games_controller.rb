class GamesController < ApplicationController
  before_action :authenticate_player!

  def index
    @games = Game.where('white_player_id != ?', current_player.id)
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
    current_game
    @y_range = (1..8).to_a
    @x_range = (1..8).to_a
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

  helper_method :render_piece
  def render_piece(x, y)
    @piece = current_game.piece.where(:row => x, :column => y)
    if @piece != nil
      @piece_text = "#{@piece.player_color} #{@piece.type}"
    end
  end

  helper_method :current_game
  def current_game
    @current_game ||= Game.find(params[:id])
  end

  helper_method :current_game

  def game_params
    params.require(:game).permit(:name)
  end
end
