class ProductsController < ApplicationController
  def index
    session[:organization] = Organization.find(params[:organization_id])
    organization_products = session[:organization].organization_products
    @products = policy_scope(Product.where(id: organization_products.pluck(:product_id)))
    # render json: @products
  end

  def filter
    @products = policy_scope(Product.where(id: session[:organization].organization_products.pluck(:product_id)).and('price beteen ? and ?', 200, 300))
    render json: @products
  end

  def new
    @product = Product.new
    authorize @product
  end

  def create
    @product = Product.new(product_params)
    authorize @product

    respond_to do |format|
      if @product.save
        @product.organization_products.create!(product_id: @product.id, organization_id: current_user.organization_user_roles.where(role_id: 1).last.organization_id)

        format.html { redirect_to(root_path, notice: 'Product was successfully created.') }
        format.json { render json: @product, status: :created }
      else
        format.html { render action: "new" }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  def bulk_create
    @product = Product.new
    authorize @product

    uploaded_file = params[:file]

    respond_to do |format|
      if uploaded_file.present?
        BulkProductCreateJob.perform_now(uploaded_file, current_user)
        format.html { redirect_to(root_path, notice: 'Product was successfully created.') }
        format.json { render json: , status: :ok }
      else
        format.html { render action: "new" }
        format.json { render json: uploaded_file.errors, status: :unprocessable_entity }
      end
    end
  end

  def download
    organization_product_ids = Organization.find(session[:organization]['id']).organization_product_ids

    if organization_product_ids.count <= 100
      respond_to do |format|
        format.html
        format.csv do
          csv_data = DownloadService.new.call(organization_product_ids)
          send_data csv_data, filename: "products-#{Date.today}.csv", type: 'text/csv; charset=utf-8', disposition: 'attachment'
        end
      end
    else
      DownloadProductCsvJob.perform_later(organization_product_ids)
      redirect_to products_path(organization_id: session[:organization]['id']), notice: 'CSV export is being processed. You will receive an email when it’s ready.'
    end
    
  end

  private

  def product_params
    params.require(:product).permit(:name, :image, :price, :sku_id)
  end
end
