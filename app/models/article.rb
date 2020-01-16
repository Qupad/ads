# frozen_string_literal: true

class Article < ApplicationRecord
  paginates_per 25
  has_many_attached :images
  belongs_to :user
  belongs_to :category
  validates :title, presence: true
  validates :text, presence: true
end
