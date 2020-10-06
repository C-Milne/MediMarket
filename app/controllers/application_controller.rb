class ApplicationController < ActionController::Base
  include ApplicationHelper
  before_action :checkInfo

  include SessionsHelper
  before_action :getInfo
  before_action :clearTerm
  before_action :delCart
  
  include CurrentCart
  before_action :set_cart

  add_flash_types :greenNotice, :redNotice, :greyNotice
end
