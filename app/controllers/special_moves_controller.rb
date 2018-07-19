class SpecialMovesController < ApplicationController
  def castle
    
  end

  private

  def castle_params
    params.permit(:kingside, :queenside)
  end
end
