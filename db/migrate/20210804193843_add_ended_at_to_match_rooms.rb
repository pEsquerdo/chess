class AddEndedAtToMatchRooms < ActiveRecord::Migration[6.1]
  def change
    add_column :match_rooms, :ended_at, :datetime
  end
end
