class AddStatusToMatchRooms < ActiveRecord::Migration[6.1]
  def change
    add_column :match_rooms, :status, :string
  end
end
