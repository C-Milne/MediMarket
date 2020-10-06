class AddFieldsToAppDataInfo < ActiveRecord::Migration[5.2]
  def change
    add_column :appdatainfos, :date, :date
    add_column :appdatainfos, :numseller, :integer
    add_column :appdatainfos, :numuser, :integer
    add_column :appdatainfos, :numproduct, :integer
    add_column :appdatainfos, :numcarts, :integer
    add_column :appdatainfos, :numcartitems, :integer
    add_column :appdatainfos, :averageproductprice, :float
    add_column :appdatainfos, :averagecartvalue, :float
  end
end
