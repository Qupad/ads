json.extract! article, :id, :title, :text, :author_id, :life_cycle, :kind, :created_at, :updated_at
json.url article_url(article, format: :json)
