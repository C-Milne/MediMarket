class ChangeColumnType < ActiveRecord::Migration[5.2]
  def change
    change_column :products, :activenumerator, :float
  end
end
