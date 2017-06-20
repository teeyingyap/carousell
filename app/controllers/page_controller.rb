class PageController < ApplicationController
  before_action :fb_sign_in_must_update_details, only: [:index] 

  def index
  	# if params[:term].present?
   #     @listings = Listing.where(nil) # creates an anonymous scope
   #     @listings = @listings.search_by_name(params[:term]).order(:name).page params[:page]
   #  else
  	  @listings = Listing.order(:name).page params[:page]
    # end 

  end
end
