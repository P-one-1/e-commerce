class CreateOrganizationProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :organization_products do |t|
      t.float :extra_charges
      t.integer :qty
      t.references :organization, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true

      t.timestamps
    end
  end
end
