class CreateSellers < ActiveRecord::Migration[5.2]
  def change
    create_table :sellers do |t|
      t.string :name
      t.float :longitude
      t.float :latitude
      t.string :address

      t.timestamps
    end
  end
end
