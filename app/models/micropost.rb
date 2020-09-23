class Micropost < ApplicationRecord
  validates :contents, presence: true
  belongs_to :user
  has_many :comments, dependent: :destroy
end
