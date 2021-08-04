class AddStartedAtToMatchRooms < ActiveRecord::Migration[6.1]
  def change
    add_column :match_rooms, :started_at, :datetime
  end
end
