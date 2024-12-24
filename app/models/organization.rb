class Organization < ApplicationRecord
    has_many :organization_user_roles
    has_many :users, through: :organization_user_roles
    has_many :roles, through: :organization_user_roles
    has_many :organization_products
    has_many :products, through: :organization_products
end
