class WorldInData::CLI


	def call
		# WorldInData::Scraper.new.make_articles
		puts "Welcome to World In Data!"
		WorldInData::Scraper.new.scrape_articles
		display_articles
	end


	def display_articles
		puts "Here is today's World in Data!"
		
		WorldInData::Article.all.each_with_index do |article, i|
			puts "#{i+1}. #{article.title}"
		end
	end

end