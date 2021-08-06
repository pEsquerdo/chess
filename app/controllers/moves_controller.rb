class MovesController < ApplicationController
  before_action :set_move, :set_piece, only: %i[show]

  def show
    @permitted_moves = @piece.permitted_moves
  end

  def update; end

  private

  def set_move
    @move = Move.last
  end

  def set_piece
    @piece = Piece.find(params[:piece_id])
  end

  def move_params
    params.require(:move).permit(:piece_id)
  end
end
