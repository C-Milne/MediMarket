module SessionsHelper

  # Logs in the given user
  def log_in(seller)
    session[:seller_id] = seller.id
    session[:userType] = "Seller"
  end

  def log_in_user(user)
    session[:user_id] = user.id
    session[:userType] = "User"
  end

  # Gathers all the info on the logged in user
  def getInfo
    if session[:userType] == "Seller"
      @usertype = "Seller"
      @CurrentSeller ||=Seller.find_by(id:session[:seller_id])
    elsif session[:userType] == "User"
      @CurrentUser ||=User.find_by(id:session[:user_id])
      if @CurrentUser.nil?
        @usertype = "Guest"
      else
        if @CurrentUser.admin == true
          @usertype = "Admin"
        else
          @usertype = "User"
        end
      end

    else
      @usertype = "Guest"
    end
  end

  # Sets the cart id to the current cart being used
  def setCart(id)
    session[:cart_id] = id
  end

  # Delete the sessions cart id
  def delCart
    session.delete(:cart_id)
  end

  # Logs out the current user
  def log_out
    session.delete(:seller_id)
    session.delete(:user_id)
    session.delete(:userType)
    session.delete(:viewedID)
    session.delete(:cart_id)
    @current_user = nil
    @usertype = nil
    @CurrentSeller = nil
  end

###############################################################################
# Used for /products/index
  def searchTerm(term)
    session[:searchTerm] = term
  end

  def giveTerm
    if session[:searchTerm].nil?
      return nil
    else
      return session[:searchTerm]
    end
  end

  def clearTerm
    session.delete(:searchTerm)
  end
end
###############################################################################
