class GamesController < ApplicationController
  before_action :authenticate_player!
  helper_method :current_game
  helper_method :render_piece

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
    @grid = multidimensional_grid(current_game.pieces)
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

  def multidimensional_grid(pieces)
    grid = []
    (1..8).each do |row|
      grid_row = []
      (1..8).each do |col|
        piece = pieces.select { |piece| piece.row == row && piece.column == col }
        if !piece.first.nil?
          grid_row << piece.first
        else
          grid_row << nil
        end
      end
      grid << grid_row
    end
    grid
  end

  def current_game
    @current_game ||= Game.find(params[:id])
  end

  def game_params
    params.require(:game).permit(:name)
  end
end
