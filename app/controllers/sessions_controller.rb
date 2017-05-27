class SessionsController < ApplicationController

  def create
    @user = User.find_by(email: params[:user][:email])  # Check if the user exists

     if @user.try(:authenticate, params[:user][:password]) 
       session[:user_id] = @user.id
       redirect_to @user
     else
    # If user's login doesn't work, send them back to the login form.
      @error = "Invalid email or password"
      render template: "sessions/new"
     end
  end



  def destroy
    session[:user_id] = nil
    flash[:notice] = "You have successfully logged out."
    redirect_to root_url
  end



end
