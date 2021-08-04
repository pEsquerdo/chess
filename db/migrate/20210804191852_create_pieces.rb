class CreatePieces < ActiveRecord::Migration[6.1]
  def change
    create_table :pieces do |t|
      t.references :player, null: false, foreign_key: true
      t.string :coordinates
      t.string :status

      t.timestamps
    end
  end
end
