class MatchRoomsController < ApplicationController
  before_action :set_match_room, :set_move, only: %i[show edit update destroy]

  # GET /match_rooms or /match_rooms.json
  def index
    @match_rooms = MatchRoom.all
  end

  # GET /match_rooms/1 or /match_rooms/1.json
  def show; end

  # GET /match_rooms/new
  def new
    @match_room = MatchRoom.new
  end

  # GET /match_rooms/1/edit
  def edit; end

  # POST /match_rooms or /match_rooms.json
  def create
    @match_room = MatchRoom.new(match_room_params)

    respond_to do |format|
      if @match_room.save
        format.html { redirect_to @match_room, notice: 'The game was started.' }
        format.json { render :show, status: :created, location: @match_room }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @match_room.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /match_rooms/1 or /match_rooms/1.json
  def update
    respond_to do |format|
      if @match_room.update(match_room_params)
        format.html { redirect_to @match_room, notice: 'Match room was successfully updated.' }
        format.json { render :show, status: :ok, location: @match_room }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @match_room.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /match_rooms/1 or /match_rooms/1.json
  def destroy
    @match_room.destroy
    respond_to do |format|
      format.html { redirect_to match_rooms_url, notice: 'Match room was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_match_room
    @match_room = MatchRoom.find(params[:id])
  end

  def set_move
    @move = @match_room.moves.last

    return unless @move.ended_at

    @move = @match_room.moves.create(started_at: @move.ended_at, player: @move.player.adversary)
  end

  # Only allow a list of trusted parameters through.
  def match_room_params
    params.require(:match_room).permit(:name)
  end
end
