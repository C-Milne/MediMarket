module SellersHelper
  def updateSellerHelper(seller, params)
    # Store reloads for the end - dont reload the page if there is still other fields to process
    reload_queue = []

    # Deal with name
    unless params[:name].blank?
      if seller.name != params[:name]
        seller.update_columns(name: params[:name].to_s)
      end
    end

    # Deal with longitude
    unless params[:longitude].blank?
      if seller.longitude != params[:longitude]
        change = true

        begin
          newlongitude = params[:longitude].to_f
          newlongitude = newlongitude.round(2)

          stringCheck = newlongitude.to_s

          if newlongitude >= 100 or stringCheck.length > 5
            change = false
          end

          if change and confirmFloat(params[:longitude])
            seller.update_columns(longitude: newlongitude)
          else
            reload_queue << "Somethings not quite right with the LONGITUDE, this field has not been updates. Remember this must be a floating point NUMBER"
          end
        end
      end
    end

    # Deal with latitude
    unless params[:latitude].blank?
      if seller.latitude != params[:latitude]
        change = true

        begin
          newlatitude = params[:latitude].to_f

          newlatitude = newlatitude.round(2)

          stringCheck = newlatitude.to_s

          if newlatitude >= 100 or stringCheck.length > 5
            change = false
          end

          if change and confirmFloat(params[:latitude])
            seller.update_columns(latitude: newlatitude)
          else
            reload_queue << "Somethings not quite right with the LATITUDE, this field has not been updates. Remember this must be a floating point NUMBER"
          end
        end
      end
    end

    # Deal with address
    unless params[:address].blank?
      if seller.address != params[:address]
        seller.update_columns(address: params[:address])
      end
    end

    # Deal with password
    unless params[:password].blank? or params[:password_confirmation].blank?
      if params[:password] == params[:password_confirmation]
        seller.password = params[:password]
        seller.password_confirmation = params[:password]
        begin
          seller.save!
        rescue => error
          reload(seller, error.message)
          return false
        end
      else
        # If passwords dont match
        reload(seller, "Passwords dont match")
        return false
      end
    end

    if reload_queue.length == 0
      return true
    else
      reload(seller, reload_queue[0])
    end
  end

  def reload(seller, message)
    respond_to do |format|
      format.html { redirect_to edit_seller_path , notice: message}
    end
  end

  def confirmFloat(string)
    string = string.split('')
    string.each do |char|
      begin
        if (48 <= char.ord and char.ord <= 57) or char.ord == 46
          next
        else
          raise "In valid character"
        end
      rescue
        return false
      end
    end
    return true
  end

end
