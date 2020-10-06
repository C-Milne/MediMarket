class AddNameIndex < ActiveRecord::Migration[5.2]
  def change
    add_index :sellers, :name, unique: true
  end
end
