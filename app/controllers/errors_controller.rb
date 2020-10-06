class ErrorsController < ApplicationController

  def routing
    if !session[:seller_id].nil?
      @is_seller_logged_in = true
      @CurrentSeller = Seller.find_by(id: session[:seller_id])
    end
    render json: {
      status: 404,
      error: :not_found,
      message: 'Where did the 403 error go'
    }, status: 404
    #render :file => "/public/404.html", :status => 404
  end
end
