module SessionsHelper

  def sign_in(user)
    remember_token = User.new_remember_token
    puts "Raw: #{remember_token}"
    cookies.permanent[:remember_token] = remember_token
    user.update_attribute(:remember_token, User.encrypt(remember_token))
    puts "User encrypt: #{user.remember_token}"
    self.current_user = user
  end

  def current_user=(user)
    @current_user = user
  end


  def current_user
    puts cookies[:remember_token]
    if session[:user_id]
      @current_user ||= User.find(session[:user_id])
    elsif cookies[:remember_token]
      puts "Raw: #{cookies[:remember_token]}"
      remember_token = User.encrypt(cookies[:remember_token])
      @current_user ||= User.find_by(remember_token: remember_token)
    end
  end

  # Returns true if current_user exists, false otherwise
  def signed_in?
    !current_user.nil?
  end




end
