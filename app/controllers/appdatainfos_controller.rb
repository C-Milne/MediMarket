class AppdatainfosController < ApplicationController
  before_action :set_appdatainfo, only: [:show, :edit, :update, :destroy]
  include ApplicationHelper

  # GET /appdatainfos
  # GET /appdatainfos.json
  def index
    if @usertype == "Admin"
      @appdatainfos = Appdatainfo.all

      @dates = []
      @appdatainfos.each do |data|
        @dates << data.date
      end

      @sellerNumbers = []
      @userNumbers = []
      @productNumbers = []
      @cartNumbers = []
      @itemInCartNumbers = []
      @averageItemInCartNumbers = []
      @averageProductPriceNumbers = []
      @averageCartValueNumbers = []
      @totalRecords = []

      @appdatainfos.each do |appdatainfo|
        @sellerNumbers << appdatainfo.numseller
        @userNumbers << appdatainfo.numuser
        @productNumbers << appdatainfo.numproduct
        @cartNumbers << appdatainfo.numcarts
        @itemInCartNumbers << appdatainfo.numcartitems
        @averageItemInCartNumbers << appdatainfo.averageitemsincart
        @averageProductPriceNumbers << appdatainfo.averageproductprice
        @averageCartValueNumbers << appdatainfo.averagecartvalue
        @totalRecords << appdatainfo.totalRecords
      end

      @CurrentNumRecords = countRecords()

    else
      redirect_to root_path
    end
  end

  # GET /appdatainfos/1
  # GET /appdatainfos/1.json
  def show
    if @usertype != "Admin"
      redirect_to root_path
    end
  end

  # GET /appdatainfos/data
  def dataView
    # Check if admin is logged in
    if @usertype == "Admin"
      # Load the data, will paginate
      @appdatainfos = Appdatainfo.order(created_at: :desc)
      @appdatainfos = @appdatainfos.paginate(page: params[:page], per_page: 30)
    else
      # Redirect other users to the home page
      redirect_to root_path
    end
  end

  # GET /appdatainfos/new
  def new
    @appdatainfo = Appdatainfo.new
  end

  # GET /appdatainfos/1/edit
  def edit
  end

  # POST /appdatainfos
  # POST /appdatainfos.json
  def create
    @appdatainfo = Appdatainfo.new(appdatainfo_params)

    respond_to do |format|
      if @appdatainfo.save
        format.html { redirect_to @appdatainfo, notice: 'Appdatainfo was successfully created.' }
        format.json { render :show, status: :created, location: @appdatainfo }
      else
        format.html { render :new }
        format.json { render json: @appdatainfo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /appdatainfos/1
  # PATCH/PUT /appdatainfos/1.json
  def update
    respond_to do |format|
      if @appdatainfo.update(appdatainfo_params)
        format.html { redirect_to @appdatainfo, notice: 'Appdatainfo was successfully updated.' }
        format.json { render :show, status: :ok, location: @appdatainfo }
      else
        format.html { render :edit }
        format.json { render json: @appdatainfo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /appdatainfos/1
  # DELETE /appdatainfos/1.json
  def destroy
    @appdatainfo.destroy
    respond_to do |format|
      format.html { redirect_to appdatainfos_url, notice: 'Appdatainfo was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_appdatainfo
      @appdatainfo = Appdatainfo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def appdatainfo_params
      params.fetch(:appdatainfo, {})
    end
end
