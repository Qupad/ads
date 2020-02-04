class AddUserToArticles < ActiveRecord::Migration[5.2]
  def self.up
    add_reference :articles, :user, foreign_key: false
  end

  def self.down
    remove_reference(:articles, :user, index: true, foreign_key: true)
  end
end
