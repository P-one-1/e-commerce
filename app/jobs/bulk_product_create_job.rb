require 'csv'

class BulkProductCreateJob < ApplicationJob
  queue_as :default

  def perform(file, user)
    organization_id = user.organization_user_roles.where(role_id: 1).first.organization_id
    products = CSV.parse(File.read(file), headers: true)
    products.by_row.each do |product|
      ActiveRecord::Base.transaction do
        new_product = Product.create(name: product[0], price: product[1], sku_id: product[2])
        OrganizationProduct.create(qty: product[3], organization_id: organization_id, product_id: new_product.id)
      end
    end
  end
end
