class MovesController < ApplicationController
  before_action :set_piece, :set_move, only: %i[edit update]
  before_action :move_to, only: %i[update]

  def edit
    @permitted_moves = @piece.permitted_moves
  end

  def update
    respond_to do |format|
      if @move.update(notation: params[:move_notation], ended_at: Time.current)
        format.html { redirect_to match_room_path @move.match_room, notice: 'Moved!' }
        format.json { render :edit, status: :ok, location: @move.match_room }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @move.match_room.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def move_to
    @move.to(@piece, params[:move_notation])
  end

  def set_piece
    @piece = Piece.find(params[:piece_id])
  end

  def set_move
    @move = Move.find(params[:id])
  end

  # def move_params
  #   params.require(:move).permit(:piece_id)
  # end
end
