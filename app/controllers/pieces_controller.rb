class PiecesController < ApplicationController
  def show
    @piece = current_piece
    @game = @piece.game
    @chess_board = Games::RenderChessboard.call(@game.pieces)
  end

  def update
    @piece = current_piece
    @game = @piece.game
    if current_player != @piece.player
      return redirect_to game_path(@game)
    end
    @piece.update_attributes(update_piece_params)
    if @piece.valid?
      redirect_to game_path(@game)
    else
      return render_status(:unprocessable_entity)
    end
  end

  private

  def update_piece_params
    params.permit(:row, :column, :id)
  end

  def current_piece
    @piece || Piece.find(params[:id])
  end

end
