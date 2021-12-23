class CreateAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :addresses do |t|
      t.string :postal_code,             null:false
      t.integer :shipping_prefecture_id, null:false
      t.string :shipping_municipality  , null:false
      t.string :shipping_address,        null:false
      t.string :building_name
      t.string :phone_number,            null:false
      t.references :order,               null: false, foreign_key: true 
      t.timestamps
    end
  end
end
