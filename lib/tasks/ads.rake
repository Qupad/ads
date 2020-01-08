namespace :ads do
  desc "TODO"
  task publish: :environment do
  	@articles = Article.where(life_cycle: 'approved')
  	@articles.update(life_cycle: 'published', published_at: Time.zone.now)
  	puts 'Done'
  end
  task archive: :environment do
  	@articles = Article.where(life_cycle: 'published')
  	@articles.each do |article|
  		article.update(life_cycle: 'archived', published_at: nil) if (Time.parse(Time.zone.now.to_s).to_i - Time.parse(article.published_at.to_s).to_i) > 259200
  	end
  	puts 'no u'
  end
end
