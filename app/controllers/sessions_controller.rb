class SessionsController < ApplicationController

  def new
    if @usertype != "Guest"
      redirect_to root_path
    end
  end

  def newuser
    if @usertype != "Guest"
      redirect_to root_path
    end
  end

  def create
    if params[:session][:email].nil?
      seller = Seller.find_by(name: params[:session][:name])
      if seller && seller.authenticate(params[:session][:password])
        # Log the seller in and redirect to their show page
        log_in(seller)
        flash[:greenNotice] = "Log in successful!"
        redirect_to "/sellers/#{seller.id}"
      else
        # Create an error message
        flash[:redNotice] = 'Invalid name/password!'
        redirect_to '/login'
      end
    else
      user = User.find_by(email: params[:session][:email])

      if user && user.authenticate(params[:session][:password])
        # Log the user in and redirect them to the user’s show page.
        log_in_user(user)
        flash[:greenNotice] = "Log in successful!"
        redirect_to user
      else
        # Create an error message.
        flash[:redNotice] = 'Invalid email/password combination' # Not quite right!
        redirect_to "/loginUser"
      end
    end
  end

  def destroy
    log_out
    flash[:greenNotice] = "Log out complete!"
    redirect_to root_url
  end

end
