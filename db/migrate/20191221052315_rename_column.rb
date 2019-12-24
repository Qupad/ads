class RenameColumn < ActiveRecord::Migration[5.2]
  def change
  	rename_column :articles, :user, :author
  end
end
