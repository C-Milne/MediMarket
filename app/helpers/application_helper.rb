module ApplicationHelper

  def cart_count_over_one
    if total_cart_items > 0
      return "<span class='tag is-dark'>#{total_cart_items}</span>".html_safe
    else
      return "<span class='tag is-dark'>0</span>".html_safe
    end
  end

  def total_cart_items
    total = @cart.line_items.map { |item| item.quantity }.sum
    return total
  end

  def checkInfo
    currentDate = Time.new
    currentDate = currentDate.to_s
    currentDate = currentDate[0..10]

    infoSearchResult = Appdatainfo.find_by(date: currentDate)
    if infoSearchResult.nil?
      allCarts = Cart.all
      allProducts = Product.all

      numberProducts = Product.count
      numberCarts = Cart.count

      cartItems = 0
      cartValue = 0
      allCarts.each do |cart|
        cartItems += cart.line_items.map { |item| item.quantity }.sum
        cart.line_items.each do |lineItem|
          cartValue += lineItem.product.price * lineItem.quantity
        end
      end

      if numberCarts == 0
        averageCartAmount = 0
        averageCartItems = 0
      else
        averageCartAmount = cartValue/numberCarts
        averageCartItems = cartItems/numberCarts
      end

      productTotal = 0
      allProducts.each do |prod|
        productTotal += prod.price
      end

      if numberProducts == 0
        productAverage = 0
      else
        productAverage = productTotal/numberProducts
      end
      numberSellers = Seller.count
      numberUsers = User.count
      totalAppRecords = numberCarts + numberProducts + numberSellers + numberUsers + LineItem.count

      Appdatainfo.create(date: currentDate, numseller: numberSellers, numuser: numberUsers,
        numproduct: numberProducts, numcarts: numberCarts, numcartitems: cartItems,
      averageproductprice: productAverage.round(2), averagecartvalue: averageCartAmount,
      averageitemsincart: averageCartItems, totalRecords: totalAppRecords)

    end

  end

  def countRecords
    totalAppRecords = Cart.count + Product.count + Seller.count + User.count + LineItem.count
    return totalAppRecords
  end
end
