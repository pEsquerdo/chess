class MovesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_match_room, :set_piece
  before_action :set_permitted_moves, only: %i[new]

  def new; end

  def create
    @move = @match_room.moves.create({ started_at: started_at, ended_at: Time.current, notation: params[:notation],
                                       player: @piece.player })

    respond_to do |format|
      if @move.save
        @move.piece_to(@piece, params[:notation])
        format.html { redirect_to @match_room, notice: 'Moved!' }
        format.json { render :show, status: :created, location: @move }
      else
        format.html { render plain: @move.errors.messages, status: :unprocessable_entity }
        format.json { render json: @move.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_match_room
    @match_room = MatchRoom.find(params[:match_room_id])
  end

  def set_permitted_moves
    @permitted_moves = @piece&.permitted_moves
  end

  def set_piece
    @piece = @match_room.pieces.find_by(id: params[:piece_id])
  end

  def started_at
    @match_room.moves&.last&.ended_at || @match_room.started_at
  end
end
