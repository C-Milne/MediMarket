module CurrentCart

  private

  def set_cart

    if @usertype == "User"
      begin
        #@cart = Cart.find(session[:cart_id])
        @cart = Cart.find(@CurrentUser.id)
      rescue ActiveRecord::RecordNotFound
        @cart = Cart.create!(id: @CurrentUser.id)
        #session[:cart_id] = @cart.id
      end
    end

  end

end
