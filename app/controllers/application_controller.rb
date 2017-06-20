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


end