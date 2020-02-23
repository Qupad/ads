class CreateArticles < ActiveRecord::Migration[5.2]
	def change
		create_table :articles do |t|
			t.string :title
			t.text :text
			t.integer :user_id, index: true, foreign_key: true
			t.integer :category_id, index: true, foreign_key: true
			t.string :life_cycle, default: 'draft'

			t.timestamps
		end
	end
end
