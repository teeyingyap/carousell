class CommentsController < ApplicationController

  def create
  	@listing = Listing.find(params[:listing_id])
  	@comment = @listing.comments.new(comment_from_params)
    @comment.user_id = current_user.id if current_user
    if @comment.save
      @new_comments = @listing.comments.new
      respond_to do |format|
          format.html do
          flash[:success] = 'Your comment has been posted.'
          redirect_to @listing
        end
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

    # if @comment.save
    #   @new_comment = @post.comments.new
    #   respond_to do |format|
    #     format.html do
    #       flash[:success] = 'Your comment has been posted.'
    #       redirect_to @post
    #     end
    #     format.js
    #   end
    # else
    #   @new_comment = @comment
    #   respond_to do |format|
    #     format.html { render @post }
    #     format.js { render action: 'failed_save' }
    #   end
    # end
  end


  private

    def comment_from_params
      params.require(:comment).permit(:content)
    end

    def find_listing
      @listing = Listing.find(params[:listing_id])
    end 

end
