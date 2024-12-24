class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :name
      t.string :image
      t.float :price
      t.string :sku_id

      t.timestamps
    end
  end
end
