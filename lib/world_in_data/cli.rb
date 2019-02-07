class WorldInData::CLI


	def call
		# WorldInData::Scraper.new.make_articles
		puts "Welcome to World In Data!"
		WorldInData::Scraper.new.scrape_articles
		# FreeCourses::Subject.display_subjects	
	end


	def display_articles
	end

end