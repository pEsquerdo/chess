class AddFamilyToPieces < ActiveRecord::Migration[6.1]
  def change
    add_column :pieces, :family, :string
  end
end
