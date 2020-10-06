module UsersHelper
  def checkValidEmail(string)
    if !User.find_by email: string
      # Check email is valid

      # Split email into user name and domain
      #######################################################
      email = string
      email = email.downcase
      index = 0

      valid = true
      splitterFound = false

      while index < email.length
        if email[index] == '@'
          splitterFound = true
          splitterLocation = index
          index = email.length + 2
        end
        if index == email.length-1 and splitterFound == false
          valid = false
        end
        index += 1
      end

      if splitterFound
        username = email[0...splitterLocation]
        domain = email[splitterLocation.. email.length]

        # Check username
        if username.length == 0
          valid = false
        end

        usernameArray = []
        for index in (0...username.length)
          usernameArray << username[index]
        end

        usernameArray.each do |index|
          if index.ord >= 48 and index.ord <= 57
          elsif index.ord >= 65 and index.ord <= 90
          elsif index.ord >= 97 and index.ord <= 122
          elsif index.ord == 95 or index.ord == 46 or index.ord == 45
          else
            valid = false
          end
        end

        if usernameArray[0].ord == 46 or usernameArray[0].ord == 45
          valid = false
        end

        ############################################################################
        domainArray = []
        for index in (0...domain.length)
          domainArray << domain[index]
        end

        if domainArray[1].ord >=97 and domainArray[1].ord <= 122
        elsif domainArray[1].ord >= 48 and domainArray[1].ord <= 57
        else
          valid = false
        end

        domainArray[1...domainArray.length-1].each do |index|
          if index.ord >= 48 and index.ord <= 57
          elsif index.ord >= 65 and index.ord <= 90
          elsif index.ord >= 97 and index.ord <= 122
          elsif index.ord == 46 or index.ord == 45
          else
            valid = false
          end
        end

        if domainArray[domainArray.length-1].ord == 46
          valid = false
        end

      end #  if splitterFound

      return valid
      ##################################################################

    end
  end

  def updateHelper(user, user_params)
    # Check each param
    #
    # Deal with admin status
    unless user_params[:admin] == '-'
      if user.admin != user_params[:admin]
        if user_params[:admin] == "True"
          bool = true
        else
          bool = false
        end
        user.update_columns(admin: bool)
      end
    end

    # Deal with email
    unless user_params.blank?
      if user.email != user_params[:email]
        # If email has been updated check the email is valid
        if checkValidEmail(user_params[:email])
          # Update email
          user.update_columns(email: user_params[:email].to_s)
        end
      end
    end

    # Deal with name
    unless user_params.blank?
      if user.name != user_params[:name]
        user.update_columns(name: user_params[:name].to_s)
      end
    end

    # Attempt to update password
    unless user_params[:password].blank? or user_params[:password_confirmation].blank?
      if user_params[:password] == user_params[:password_confirmation]
        user.password = user_params[:password]
        user.password_confirmation = user_params[:password]
        begin
          user.save!
        rescue => error
          puts "Save issue"
          puts error.message
          reload(user, error.message)
          return false
        end
      else
        # If passwords dont match
        reload(user, "Passwords dont match")
        return false
      end
    end

    return true

  end

  def reload(user, message)
    respond_to do |format|
      format.html { redirect_to edit_user_path , notice: message}
    end
  end
end
