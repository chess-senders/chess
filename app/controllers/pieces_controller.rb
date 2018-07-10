class PiecesController < ApplicationController
  def show
    @current_piece = Piece.find(params[:id])
    @game = @current_piece.game
    @chess_board = Games::RenderChessboard.call(@game.pieces)
    render template: 'games/show'
  end

  private

  def piece_params
    params.require(:piece).permit(:id)
  end

end
