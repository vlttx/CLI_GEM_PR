class WorldInData::Article

	attr_accessor :title, :date, :author, :url, :description
	
	@@all = []


	def self.all
		@@all 
	end

	def content_description
		@description = WorldInData::Scraper.new(url).scrape_description
	end

	def open_in_browser
		system("open '#{url}'")
	end

	def save
		@@all << self
	end

end