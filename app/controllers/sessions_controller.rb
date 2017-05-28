class SessionsController < ApplicationController

  def create
    # byebug
    @user = User.find_by(email: params[:session][:email]) 

     if @user.try(:authenticate, params[:session][:password]) 
       session[:user_id] = @user.id
       redirect_to @user
     else
    # If user's login doesn't work, send them back to the login form.
      flash[:error] = "Invalid email or password"
      render template: "sessions/new"
     end
  end



  def destroy
    session[:user_id] = nil
    flash[:notice] = "You have successfully logged out."
    redirect_to root_url
  end

  private

  def session_params
    params.require(:session).permit(:email, :password)
  end

end
