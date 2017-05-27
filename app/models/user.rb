class User < ApplicationRecord
  validates :username, presence: { message: "*Username is a required field" }
  validates :username, format: { without: /\s/, message: "must contain no spaces" }
  validates :username, uniqueness: true

  validates :email, presence: { message: "Email is a required field" }
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/, message: "*Only valid email allowed"}
  validates :email, uniqueness: true



  has_secure_password
end
