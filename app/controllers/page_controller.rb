class PageController < ApplicationController
  def index
  	if params[:term].present?
       @listings = Listing.where(nil) # creates an anonymous scope
       @listings = @listings.search_by_name(params[:term]).order(:name)
       respond_to do |format|
       	  format.html
          format.js
       end
    else
  	  @listings = Listing.order(:name)
    end 

  end
end
