class CreateMoves < ActiveRecord::Migration[6.1]
  def change
    create_table :moves do |t|
      t.references :match_room, null: false, foreign_key: true
      t.references :player, null: false, foreign_key: true
      t.string :notation
      t.datetime :started_at
      t.datetime :ended_at

      t.timestamps
    end
  end
end
