class PlayersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_match_room

  def create
    if @match_room.players.size.zero?
      @player = @match_room.players.create(user_id: current_user.id, color: :white)
    elsif @match_room.players.size.eql?(1)
      @player = @match_room.players.create(user_id: current_user.id, color: :black)
    end
    redirect_to @match_room
  end

  def destroy
    @player = @match_room.players.where(user_id: current_user.id).destroy_all
    redirect_to match_rooms_path
  end

  private

  def set_match_room
    @match_room = MatchRoom.find(params[:match_room_id])
  end
end
