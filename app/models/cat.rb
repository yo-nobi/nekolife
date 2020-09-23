class Cat < ApplicationRecord
  validates :name, presence: true, length: { maximum: 50 }
  validates :variety, presence: true
  validates :contents, presence: true
  mount_uploader :image, ImageUploader
  belongs_to :user
end
