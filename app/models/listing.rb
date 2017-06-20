class Listing < ApplicationRecord
  include PgSearch
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :transactions, dependent: :destroy
  mount_uploaders :photos, PhotoUploader

  enum condition: [:Used, :New]
  enum status: [:Unsold, :Sold]
  enum category: [:Electronics, :Fashion, :Lifestyle, :Entertainment, :Other]

  pg_search_scope :search_by_name, :against => [:name], using: { tsearch: { prefix: true, dictionary: "english" } }
  paginates_per 8
  validates :name, presence: true
  validates :price, presence: true
  validates :condition, presence: true

  # def self.category_list #no need to list this out, just use Listing.categories.keys
  #   [
  #     ["Electronics", 0],
  #     ["Fashion", 1],
  #     ["Lifestyle", 2],
  #     ["Entertainment", 3],
  #     ["Other", 4]
  #   ]
  # end


end
 