class AddAverageItemsFieldToAppDataInfo < ActiveRecord::Migration[5.2]
  def change
    add_column :appdatainfos, :averageitemsincart, :float
  end
end
