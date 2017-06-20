class CommentsController < ApplicationController
  before_action :check_sign_in
  before_action :fb_sign_in_must_update_details 
  def create
  	@listing = Listing.find(params[:listing_id])
  	@comment = @listing.comments.new(comment_from_params)
    @comment.user_id = current_user.id if current_user
    if @comment.save
      @new_comments = @listing.comments.new
      respond_to do |format|
        format.html
        format.js
      end
      # # redirect_to @listing 
      #   respond_to do |format|
      #     format.html { redirect_to listing_path(@listing) }
      #     format.js 
      #   end
    else
      render 'listings/show'
    end

  end


  private

    def comment_from_params
      params.require(:comment).permit(:content)
    end

    def find_listing
      @listing = Listing.find(params[:listing_id])
    end 

    def check_sign_in
      unless signed_in?
        flash[:error] = 'Please sign in.'
        redirect_to '/login'
      end 
    end  

end
