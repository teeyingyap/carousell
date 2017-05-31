class ListingsController < ApplicationController

  def index
    if signed_in?
       @listings = current_user.listings.order(:name)
       flash[:error] = "You don't have any listings!" if @listings == []
    elsif 
      if params[:term].present?
        @listings = Listing.where(nil) # creates an anonymous scope
        @listings = @listings.search_by_name(params[:term]).order(:name)
          respond_to do |format|
          format.html
          format.js
       end
      end 
    end 
  end



  def new
    @listing = Listing.new  #initialize an empty object for the form, so that we can fill in with details using the form.
    render template: "listings/new"
  end

  def create
   @listing = Listing.new(listing_from_params)
   @listing.user_id = current_user.id if current_user
     if @listing.save
       redirect_to @listing
     else
        render 'new'
     end
  end

  def show
    @listing = Listing.find(params[:id])
    @comments = @listing.comments.order("created_at DESC")
    @new_comments = @listing.comments.new
    @transaction = @listing.transactions.new
  end

  def edit
    @listing = Listing.find(params[:id])
  end 

  def update
    @listing = Listing.find(params[:id])
    @listing.update(listing_from_params)
    redirect_to @listing
  end 


  def listing_from_params
    params.require(:listing).permit(:name, :price, :condition, :description, photos: [], tag_list:[])
  end


end
