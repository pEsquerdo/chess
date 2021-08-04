class AddColorToPlayers < ActiveRecord::Migration[6.1]
  def change
    add_column :players, :color, :string
  end
end
