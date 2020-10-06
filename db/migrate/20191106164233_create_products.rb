class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :substancename
      t.string :nonproprietaryname
      t.string :propname
      t.string :producttype
      t.string :dosageform
      t.string :routename
      t.string :marketingcategory
      t.integer :activenumerator
      t.string :activeingredunit
      t.references :seller, foreign_key: true

      t.timestamps
    end
  end
end
