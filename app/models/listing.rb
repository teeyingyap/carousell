class Listing < ApplicationRecord
  belongs_to :user
  mount_uploaders :photos, PhotoUploader

  enum condition: [:Used, :New]
end
