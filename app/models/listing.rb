class Listing < ApplicationRecord
  include PgSearch
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :transactions
  mount_uploaders :photos, PhotoUploader

  enum condition: [:Used, :New]
  enum status: [:Unsold, :Sold]

  pg_search_scope :search_by_name, :against => [:name], using: { tsearch: { prefix: true } }
end
