class Role < ApplicationRecord
  has_many :organization_user_roles
  has_many :organizations, through: :organization_user_roles
  has_many :users, through: :organization_user_roles
end
