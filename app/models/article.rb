# frozen_string_literal: true

class Article < ApplicationRecord
  paginates_per 25
  has_many_attached :images
  belongs_to :user
  belongs_to :category
  validates :title, presence: true
  validates :text, presence: true

  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  Article.import

  settings index: { number_of_shards: 1 } do
    mappings dynamic: 'false' do
      indexes :title
      indexes :text
    end
  end

  def self.search_published(query)
    __elasticsearch__.search(
      query: {
        bool: {
          must: [
            {
              multi_match: {
                query: query,
                fields: %i[title text]
              }
            },
            {
              match: {
                life_cycle: 'published'
              }
            }
          ]
        }
      }
    )
  end
end
