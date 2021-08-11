class PlayersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_match_room

  def create
    @player = @match_room.players.where(user_id: current_user.id, color: set_player_color).first_or_create
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

  def set_player_color
    if @match_room.players.size.zero?
      :white
    elsif @match_room.players.size.eql? 1
      :black
    end
    # enable_first_move whites
  end

  # def enable_first_move(player)
  #   moves.create(started_at: Time.current, player: player)
  # end
end
