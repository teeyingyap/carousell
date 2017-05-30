class PageController < ApplicationController
  def index
  	if params[:term].present?
       @listings = Listing.where(nil) # creates an anonymous scope
       @listings = @listings.search_by_name(params[:term]).order(:name)
    else
  	  @listings = Listing.order(:name)
    end 
  end
end
