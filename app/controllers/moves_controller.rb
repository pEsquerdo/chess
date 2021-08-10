class MovesController < ApplicationController
  before_action :set_piece, :set_player_moves, only: :edit
  before_action :move_to, only: :update

  def edit; end

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

  def set_player_moves
    set_move
    @move.player.set_permitted_moves # issue: colocar isso ao criar uma partida, ou ao atualizar uma peça (coloquei la mas nao esta funcionando)
    @player_moves = @piece ? @move.player.permitted_moves[params[:piece_id]] : @move.player.permitted_moves
  end

  def move_to
    set_move.to(set_piece, params[:move_notation])
  end

  def set_piece
    @piece = Piece.find_by(id: params[:piece_id])
  end

  def set_move
    @move = Move.find(params[:id])
  end
end
