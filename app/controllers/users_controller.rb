class UsersController < ApplicationController

  def new
    @user = User.new  #initialize an empty object for the form, so that we can fill in with details using the form.
    render template: "users/new"
  end 

  def show 
    @user = User.find(params[:id])
  end 


  def create
  	 @user = User.new(user_from_params)
   
     if @user.save
       session[:user_id] = @user.id
       flash[:success] = "Welcome to Carousell!"
       redirect_to @user
     else
       flash[:error] = "Fail to sign up"
       render template: "users/new"
     end

  end

  private

  def user_from_params
   params.require(:user).permit(:email, :username, :password)
  end

end
