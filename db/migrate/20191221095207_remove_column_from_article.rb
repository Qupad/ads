class RemoveColumnFromArticle < ActiveRecord::Migration[5.2]
  def change
    remove_column :articles, :kind, :string
  end
end
