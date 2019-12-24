class RemoveColumn < ActiveRecord::Migration[5.2]
  def self.up
  	remove_reference(:articles, :author, index: true, foreign_key: true)
  end
end
