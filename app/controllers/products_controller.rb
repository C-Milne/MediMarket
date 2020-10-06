class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  skip_before_action :clearTerm, only: [:index]

  # GET /products
  # GET /products.json
  def index

    @options = ["Price - Low -> High", "Price - High -> Low", "No Sort"]

    if params[:order].nil?
      helpers.clearTerm
    end

    @term = helpers.giveTerm

    if params[:term]
      @products = Product.where('lower(substancename) LIKE ?', "%#{params[:term].downcase}%")
      helpers.searchTerm(params[:term])
    elsif !@term.nil?
      @products = Product.where('lower(substancename) LIKE ?', "%#{@term.downcase}%")
    else
      @products = Product.all
    end

    if !params[:order].nil? && params[:order] == "0"
      @products = @products.order(:price).paginate(page: params[:page], per_page: 30)
      @ordering = "Price - Low -> High"
    elsif !params[:order].nil? && params[:order] == "1"
      @products = @products.order(price: :desc).paginate(page: params[:page], per_page: 30)
      @ordering = "Price - High -> Low"
    else
      @products = @products.paginate(page: params[:page], per_page: 30)
      @ordering = "No Ordering"
    end


  end

  # GET /products/1
  # GET /products/1.json
  def show
    @seller = Seller.find_by(id: @product.seller_id)

    if @usertype == "Admin" or @usertype == "Seller"
      @permission = true
    else
      @permission = false
    end

  end

  # GET /products/new
  def new

    if @usertype == "Admin" or @usertype == "Seller"
      @permission = true
    else
      @permission = false
    end

    if @permisson == false
      redirect_to "/"
    else

      if @usertype == "Seller"
        @Seller = Seller.where(id: @CurrentSeller.id)
      else
        if !params[:seller_id].nil?
          @Seller = Seller.where(id: params[:seller_id])
        else
          @Seller = Seller.all
        end
      end

      @product = Product.new
    end

  end

  # GET /products/1/edit
  def edit

    if @usertype == "Seller" or @usertype == "Admin"
      # Get product ID and compare the seller to the currently logged in seller
      @currentProduct = Product.where(id: params[:id])

      if @usertype != "Admin"
        @currentProduct.each do |product|
          if product.seller_id != @CurrentSeller.id
            redirect_to "/"
          end
        end
        @Seller = Seller.where(id: @CurrentSeller.id)
      else
        # If admin is logged in
        @currentProduct.each do |product|
          @Seller = Seller.where(id: product.seller_id)
        end
      end

    else
      redirect_to root_path
    end


  end

  # POST /products
  # POST /products.json
  def create

    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update

    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy

    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:substancename, :nonproprietaryname, :propname, :producttype, :dosageform, :routename, :marketingcategory, :activenumerator, :activeingredunit, :seller_id, :price, :term, :order)
    end
end
