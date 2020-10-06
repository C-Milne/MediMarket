class AddTotalRecords < ActiveRecord::Migration[5.2]
  def change
    add_column :appdatainfos, :totalRecords, :integer, :default => 0
  end
end
