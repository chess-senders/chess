class PiecesController < ApplicationController
  def show
    @piece = current_piece
    @game = @piece.game
    @pieces = @game.pieces.where(captured: false)
    @chess_board = Games::RenderChessboard.call(@pieces)
  end

  def update
    @piece = current_piece
    @game = @piece.game
    # if current_player != @piece.player
    #   return redirect_to game_path(@game)
    # end
    if @piece.move_to!(new_square_params)
      update_state(@game)
      redirect_to game_path(@game)
    else
      redirect_to game_path(@game)
    end
  end

  private

  def new_square_params
    @params = params.permit(:row, :column, :id)
    @params.each { |k, v| @params[k] = v.to_i }
  end

  def current_piece
    @piece || Piece.find(params[:id])
  end

  def update_state(game)
    return game.update(state: 2) if game.state == "White's Turn"
    return game.update(state: 1) if game.state == "Black's Turn"
  end
end
