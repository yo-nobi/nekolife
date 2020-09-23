class Cat < ApplicationRecord
  validates :name, presence: true, length: { maximum: 50 }
  mount_uploader :image, ImageUploader
  belongs_to :user
end
