class CreateOrganizationUserRoles < ActiveRecord::Migration[7.0]
  def change
    create_table :organization_user_roles do |t|
      t.references :role, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.references :organization, null: false, foreign_key: true


      t.timestamps
    end
  end
end
