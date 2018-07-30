class PiecesController < ApplicationController
  def update
    @piece = current_piece
    @game = @piece.game
    # unless current_player == @piece.player
    #   return redirect_to game_path(@game)
    # end
    Games::UpdateState.call(@game) if @piece.move_to!(new_square_params)
    ActionCable.server.broadcast 'messages', game_state: @game.state
  end

  private

  def new_square_params
    @params = params.permit(:row, :column, :id)
    @params.each { |k, v| @params[k] = v.to_i }
  end

  def current_piece
    @piece || Piece.find(params[:id])
  end
end
