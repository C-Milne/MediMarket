class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  include UsersHelper

  # GET /users
  # GET /users.json
  def index

    if @usertype != "Admin"
      redirect_to root_path
    else
      if params[:userSearch].nil?
        @users = User.paginate(page: params[:page], per_page: 30)
      else
        @users = User.where('lower(name) LIKE ?', "%#{params[:userSearch].downcase}")
        @users = @users.paginate(page: params[:page], per_page: 30)
      end
    end

  end

  def admin

    if @usertype != "Admin"
      redirect_to root_path
    end

  end

  # GET /users/1
  # GET /users/1.json
  def show

    @user = User.find(params[:id])

    if @usertype != "Guest"
      if @usertype == "Admin"
        @ownerPrivileges = true

      elsif !@CurrentUser.nil?
        if @CurrentUser.id == @user.id
          @ownerPrivileges = true
        end
      else
        @ownerPrivileges = false
      end
    else
      @ownerPrivileges = false
    end

    if @ownerPrivileges == false
      redirect_to root_path
    end

  end

  # GET /users/new
  def new

    if @usertype == "Guest" or @usertype == "Admin"
    else
      redirect_to "/"
    end

    @user = User.new
  end

  # GET /users/1/edit
  def edit

    if @usertype == "Admin"
      @permission = true
    elsif @usertype == "User"
      @user = User.find(params[:id])
      if @user.id == @CurrentUser.id
        @permission = true
      else
        redirect_to root_path
      end
    else
      redirect_to root_path
    end

    if @permission
      @BoolOptions = ['-', 'True', 'False']
    end

  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save

        if @usertype == "Guest"
          helpers.log_in_user(@user)
        end

        format.html { redirect_to @user, greenNotice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update

      @user = User.find(params[:id])
      # Check if user has permission to update this seller
      if @usertype != "Guest" and @usertype != "Seller"
        if @usertype == "Admin"
          @ownerPrivileges = true
        elsif !@CurrentUser.nil?
          if @CurrentUser.id == @user.id
            @ownerPrivileges = true
          end
        else
          @ownerPrivileges = false
        end
      else
        @ownerPrivileges = false
      end

      if @ownerPrivileges
        if updateHelper(@user, user_params)
          respond_to do |formating|
            formating.html { redirect_to @user, greenNotice: "User updated"}
          end
        end
      end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy

    if @usertype != "Guest"
      if @usertype == "Admin"
        @ownerPrivileges = true

      elsif !@CurrentUser.nil?
        if @CurrentUser.id == @user.id
          @ownerPrivileges = true
        end
      else
        @ownerPrivileges = false
      end
    else
      @ownerPrivileges = false
    end

    if @ownerPrivileges == false
      redirect_to root_path
    else

      if @usertype != "Admin"
        helpers.log_out
      end

      @user.destroy
      respond_to do |format|
        format.html { redirect_to users_url, greenNotice: 'User was successfully destroyed.' }
        format.json { head :no_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :admin)
    end
end
