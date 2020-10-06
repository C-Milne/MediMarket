class SellersController < ApplicationController
  before_action :set_seller, only: [:edit,:destroy]
  include SellersHelper
  include SessionsHelper

  # GET /sellers
  # GET /sellers.json
  def index

    if params[:searchName].nil?
      @sellers = Seller.paginate(page: params[:page], per_page: 30)
    else
      @sellers = Seller.where('lower(name) LIKE ?', "%#{params[:searchName].downcase}")
      @sellers = @sellers.paginate(page: params[:page], per_page: 30)
    end

  end

  # GET /sellers/1
  # GET /sellers/1.json
  def show
    @seller = Seller.find(params[:id])

    if @usertype != "Guest"
      if @usertype == "Admin"
        @ownerPrivileges = true

      elsif !@CurrentSeller.nil?
        if @CurrentSeller.id == @seller.id
          @ownerPrivileges = true
        end
      else
        @ownerPrivileges = false
      end
    end

    # Get all the products sold by the Seller
    @SellerItems = Product.where(seller_id: @seller.id)

  end

  # GET /sellers/new
  def new

    if @usertype == "Guest" or @usertype == "Admin"
    else
      redirect_to "/"
    end

    @seller = Seller.new
  end

  # GET /sellers/1/edit
  def edit

    if @usertype == "Admin"
      @permission = true
    elsif @usertype == "Seller"
      @seller = Seller.find(params[:id])
      if @seller.id == @CurrentSeller.id
        @permission = true
      else
        redirect_to root_path
      end
    else
      redirect_to root_path
    end

  end

  # POST /sellers
  # POST /sellers.json
  def create
    @seller = Seller.new(seller_params)

    # @seller = Seller.new({"name" => seller_params["name"], "longitude" => seller_params["longitude"],
    #   "latitude" => seller_params["latitude"], "address" => seller_params["address"],
    #   "password_digest" => seller_params["password"]})

    respond_to do |format|
      if @seller.save
        if @usertype == "Guest"
          helpers.log_in(@seller)
        end

        format.html { redirect_to @seller, greenNotice: 'Seller was successfully created.' }
        format.json { render :show, status: :created, location: @seller }
      else
        format.html { render :new }
        format.json { render json: @seller.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sellers/1
  # PATCH/PUT /sellers/1.json
  def update
      @seller = Seller.find(params[:id])
      # Check if user has permission to update this seller
      if @usertype != "Guest" and @usertype != "User"
        if @usertype == "Admin"
          @ownerPrivileges = true
        elsif !@CurrentSeller.nil?
          if @CurrentSeller.id == @seller.id
            @ownerPrivileges = true
          end
        else
          @ownerPrivileges = false
        end
    else
      @ownerPrivileges = false
    end

    if @ownerPrivileges
        if updateSellerHelper(@seller, params[:seller]) == true
          respond_to do |formating|
            puts "Reload updated"
            formating.html { redirect_to @seller, greenNotice: "Seller updated"}
          end
        end
    else
      redirect_to "/404"
    end
  end


  # DELETE /sellers/1
  # DELETE /sellers/1.json
  def destroy

    if @usertype != "Guest"
      if @usertype == "Admin"
        @ownerPrivileges = true
      elsif !@CurrentSeller.nil?
        if @CurrentSeller.id == @seller.id
          @ownerPrivileges = true
        end
      else
        @ownerPrivileges = false
      end
    else
      @ownerPrivileges = false
    end

    if @ownerPrivileges

      @SellerItems = Product.where(seller_id: @seller.id)

      @SellerItems.each do |item|
        item.destroy
      end

      if @usertype != "Admin"
        helpers.log_out
      end

      helpers.getInfo

      @seller.destroy
      respond_to do |format|
        format.html { redirect_to sellers_url, greenNotice: 'Seller was successfully destroyed.' }
        format.json { head :no_content }
        end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_seller
      @seller = Seller.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def seller_params
      params.require(:seller).permit(:name, :longitude, :latitude, :address, :password, :password_confirmation, :new_password, :new_password_confirmation)
    end
end
