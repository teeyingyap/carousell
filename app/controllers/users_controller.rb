class UsersController < ApplicationController
  before_action :check_current_user, only: [:edit, :update] 
  before_action :fb_sign_in_must_update_details, only: [:show] 
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
      sign_in @user
      flash[:success] = "Welcome to Jarousell!"
      redirect_to @user
    else
      respond_to do |format|
        format.html { redirect_to new_user_path}
        format.js { @user }
      end
    end
  end
  
  # def create
  #    @user = User.new(user_from_params)
   
  #    if @user.save
  #      session[:user_id] = @user.id
  #      sign_in(@user)
  #      flash[:success] = "Welcome to Carousell!"
  #      redirect_to @user
  #    else
  #      flash[:error] = "Fail to sign up"
  #      render template: "users/new"
  #    end

  # end


  def edit
    @user = User.find(params[:id])
  end 

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_update_params)
      @user.has_edited = true
      @user.save
      flash[:notice] = "Your profile is updated successfully." #change has_edited boolean to true
      redirect_to @user
    else
      # byebug
      render template: "users/edit"
    end 
  end 

  private

  def user_from_params
   params.require(:user).permit(:email, :username, :password, :avatar, :bio)
  end

  def user_update_params
    params.require(:user).permit(:username, :avatar, :bio)
  end

  def check_current_user
    if current_user.id.to_s != params[:id]
      flash[:error] = "You shall not pass!!!"
      redirect_to root_path
    end
  end 


end
