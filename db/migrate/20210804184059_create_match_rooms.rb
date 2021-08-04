class CreateMatchRooms < ActiveRecord::Migration[6.1]
  def change
    create_table :match_rooms do |t|
      t.string :name

      t.timestamps
    end
  end
end
