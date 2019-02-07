class WorldInData::Article

	attr_accessor :title, :date, :author, :url, :description

	@@all = []


	def self.all
		@@all 
	end

	def self.content_description(url)
		@description = WorldInData::Scraper.new(url).scrape_description
		@description.gsub("  ", " ")
	end

	def open_in_browser
		system("open '#{url}'")
	end

	def save
		@@all << self
	end

end