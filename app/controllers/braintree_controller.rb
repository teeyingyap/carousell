class BraintreeController < ApplicationController
  def new
    @client_token = Braintree::ClientToken.generate
    @transaction = Transaction.find(params[:transaction])
  end

  def checkout
    nonce_from_the_client = params[:checkout_form][:payment_method_nonce]
    price =  Transaction.find(params[:checkout_form][:transaction]).listing.price.to_s
    result = Braintree::Transaction.sale(
      :amount => price, 
      :payment_method_nonce => nonce_from_the_client,
      :options => {
        :submit_for_settlement => true
       }
    )

    if result.success? #if success then create reservation #put this whole thing in reservation controller
      @transaction = Transaction.find(params[:checkout_form][:transaction])
      @user = User.find(@transaction.listing.user_id)
      redirect_to :root, :flash => { :success => "Transaction successful!" }
      @transaction.listing.update_attribute(:status, 1)
    else
      redirect_to :root, :flash => { :error => "Transaction failed. Please try again." }
    end 
  end

end
