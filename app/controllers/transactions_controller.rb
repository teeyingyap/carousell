class TransactionsController < ApplicationController
  def create
  	@listing = Listing.find(params[:listing_id])
    @transaction = @listing.transactions.new(params[:transaction])
    @transaction.user_id = current_user.id if current_user

    if @transaction.save
      redirect_to "/braintree/new?transaction=#{@transaction.id}"
    else 
      @error = @transaction.errors.full_messages
      render 'listings/show'
    end
  end



end
