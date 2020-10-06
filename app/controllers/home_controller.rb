class HomeController < ApplicationController
  include SessionsHelper

  def index
    @recentProducts = Product.order(:created_at).last(10)
    @recentProducts = @recentProducts.reverse()
  end

end
