class ChangeDateColumnToString < ActiveRecord::Migration[5.2]
  def change
    change_column :appdatainfos, :date, :string
  end
end
