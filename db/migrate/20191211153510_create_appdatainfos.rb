class CreateAppdatainfos < ActiveRecord::Migration[5.2]
  def change
    create_table :appdatainfos do |t|

      t.timestamps
    end
  end
end
