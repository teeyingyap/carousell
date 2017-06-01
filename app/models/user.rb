class User < ApplicationRecord

  has_many :authentications, :dependent => :destroy
  has_many :listings, :dependent => :destroy
  has_many :comments, :dependent => :destroy
  has_many :transactions
  before_save :create_remember_token

  validates :username, presence: { message: "*Username is a required field" }
  validates :username, format: { without: /\s/, message: "must contain no spaces" }
  validates :username, uniqueness: true

  validates :email, presence: { message: "*Email is a required field" }
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/, message: "*Only valid email allowed"}
  validates :email, uniqueness: true
  
  validates :password, length: { minimum: 8, maximum: 20, message: "*Password must be within 8 to 20 characters" } 
  
  has_secure_password

  mount_uploader :avatar, AvatarUploader


  def self.create_with_auth_and_hash(authentication, auth_hash)
  	#byebug
      user = User.new(username: auth_hash["extra"]["raw_info"]["first_name"], email: auth_hash["extra"]["raw_info"]["email"])
      user.password_digest = SecureRandom.hex(30)
      user.save
      user.authentications << (authentication)    
      return user
  end

  def fb_token
    x = self.authentications.where(:provider => :facebook).first
    return x.token unless x.nil?
  end



  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  private

  def create_remember_token
    self.remember_token = User.encrypt(User.new_remember_token)
  end



  # def facebook_user?
  #   provider != nil && uid != nil
  # end


  # def self.authenticate!(email, password)
  #   user = User.find_by(email: email)
  #   return false if user.nil? || (user.password != password)
  #   return user
  # end

end
