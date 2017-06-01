class PageController < ApplicationController
  def index
  	if params[:term].present?
       @listings = Listing.where(nil) # creates an anonymous scope
       @listings = @listings.search_by_name(params[:term]).order(:name).page params[:page]
    else
  	  @listings = Listing.order(:name).page params[:page]
    end 

  end
end
