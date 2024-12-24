require 'csv'

class DownloadProductCsvJob < ApplicationJob
  queue_as :default

  def perform(organization_product_ids)
    CSV.generate(headers: true) do |csv|
      csv << ['name', 'price', 'sku_id', 'qty']
      organization_product_ids.each do |opid|
        op = OrganizationProduct.find(opid)
        product = op.product
        csv << [product.name, product.price, product.sku_id, op.qty]
      end
    end
  end
end
