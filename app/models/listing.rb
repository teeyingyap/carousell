class Listing < ApplicationRecord
  include PgSearch
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :transactions, dependent: :destroy
  mount_uploaders :photos, PhotoUploader

  enum condition: [:Used, :New]
  enum status: [:Unsold, :Sold]

  pg_search_scope :search_by_name, :against => [:name], using: { tsearch: { prefix: true } }
 
  validates :name, presence: true
  validates :price, presence: true
  # validates :condition, presence: true
end
