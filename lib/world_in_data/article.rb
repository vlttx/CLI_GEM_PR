class WorldInData::Article

	attr_accessor :title, :date, :author, :url, :description

	@@all = []

	def self.all
		@@all 
	end

	def content_description
		description ||= WorldInData::Scraper.new(url).scrape_description
		description.gsub("  ", " ")
	end

	def self.find_selected_article(id)
		@article = @@all[id.to_i-1]
	end

	def self.display_all
		@@all.each.with_index(1) do |article, i|
		puts "#{i}. #{article.title}"
	end
	end

	def open_in_browser
		system("open '#{url}'")
	end

	def save
		@@all << self
		self
	end

end
