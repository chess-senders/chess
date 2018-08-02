class PiecesController < ApplicationController
  def update
    @piece = current_piece
    @game = @piece.game
    @game_pieces = @game.pieces.where(captured: false)

    unless current_player == @piece.player
      return redirect_to game_path(@game)
    end

    Games::UpdateState.call(@game) if @piece.move_to!(new_square_params)
    flash[:notice] = "#{@game.white_player.playername} is in check" if @game.check?(@game.white_player)
    flash[:notice] = "#{@game.black_player.playername} is in check" if @game.check?(@game.black_player)

    ActionCable.server.broadcast('game',
      html: ApplicationController.render(
        partial: 'games/chessboard',
        locals: {
          :@game => @game,
          :@chess_board => Games::RenderChessboard.call(@game_pieces)
        }
      )
    )
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
