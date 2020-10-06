class RemovePasswordFromProducts < ActiveRecord::Migration[5.2]
  def change
    remove_column :products, :password, :string
  end
end
