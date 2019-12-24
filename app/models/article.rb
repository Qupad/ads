class Article < ApplicationRecord
  has_many_attached :images
  belongs_to :user
  belongs_to :category
	validates :title, presence: true
	validates :text, presence: true
end
