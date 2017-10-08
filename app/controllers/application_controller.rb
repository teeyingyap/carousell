class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  def fb_sign_in_must_update_details
    if signed_in?
      if current_user.has_edited == false
        flash[:notice] = "Please update your username."
        redirect_to edit_user_path(current_user)
      end 
    end
  end

  def check_current_user(id)
    if current_user && id
      if current_user.id.to_s != id
        flash[:error] = "You shall not pass!!!"
        redirect_to root_path
      end
    end
  end 
end