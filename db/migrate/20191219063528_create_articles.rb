class CreateArticles < ActiveRecord::Migration[5.2]
  def change
    create_table :articles do |t|
      t.string :title
      t.text :text
      t.references :author, foreign_key: true
      t.string :life_cycle, default: 'draft'
      t.string :kind

      t.timestamps
    end
  end
end
