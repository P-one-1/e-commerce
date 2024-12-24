class Product < ApplicationRecord
    has_many :organization_products
    has_many :organizations, through: :organization_products
end
