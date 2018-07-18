class SpecialMovesController < ApplicationController
  def castle
  end

  private

  def move_params
    params.permit(:kingside, :queenside)
  end
end
