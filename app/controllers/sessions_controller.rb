class SessionsController < ApplicationController
include SessionsHelper
  def create
    # byebug
    @user = User.find_by(email: params[:session][:email]) 

     if @user && @user.try(:authenticate, params[:session][:password]) 
       session[:user_id] = @user.id
       sign_in(@user)
       redirect_to root_url
     else
    # If user's login doesn't work, send them back to the login form.
      # flash[:error] = "Invalid email or password"
      # render template: "sessions/new"
        respond_to do |format|
          format.html { redirect_to login_path}
          format.js { @user }
        end
     end
  end



  def create_from_omniauth
    auth_hash = request.env["omniauth.auth"]
    authentication = Authentication.find_by_provider_and_uid(auth_hash["provider"], auth_hash["uid"]) || Authentication.create_with_omniauth(auth_hash)
    if authentication.user
      user = authentication.user 
      authentication.update_token(auth_hash)
      @next = root_url
      @notice = "Signed in!"
    else
      user = User.create_with_auth_and_hash(authentication, auth_hash)
      @next = edit_user_path(user)   
      @notice = "User created - confirm or edit details..."
    end
    session[:user_id] = user.id
    redirect_to @next, :notice => @notice
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
