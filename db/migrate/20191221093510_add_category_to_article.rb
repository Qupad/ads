class AddCategoryToArticle < ActiveRecord::Migration[5.2]
  def self.up
    add_reference :articles, :category, foreign_key: true
  end

  def self.down
  remove_reference(:articles, :category, index: true, foreign_key: true)
	end
end
