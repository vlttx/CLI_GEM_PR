class WorldInData::Article

	attr_accessor :title, :date, :author, :url, :description

	@@all = []


	def self.all
		@@all 
	end

	def content_description
		@description ||= WorldInData::Scraper.new(url).scrape_description
		@description.gsub("  ", " ")
	end

	def self.find_selected_article(id)
		@article = @@all[id.to_i-1]
	end

	def self.display_all
		@@all.each.with_index(1) do |article, i|
		puts "#{i}. #{article.title}"
	end
	end

	def self.print_selected_article
		puts ""
		puts @article.title.colorize(:blue)
		puts ""
		puts @article.content_description
		puts ""
		puts "Author(s): #{@article.author}"
		puts ""
		puts "Posting date: #{@article.date}" 
		puts ""
		puts "Prefer to see the full article and data visualization?".colorize(:blue)
		puts "Enter Y or YES to open in your browser.".colorize(:blue)
		puts ""
		puts "To go back to the list, enter LIST.".colorize(:blue)
		puts ""
		puts "To read another article from the list, just enter its number.".colorize(:blue)
		puts ""
		puts "To exit, enter EXIT".colorize(:blue)
		puts ""
	end

	def open_in_browser
		system("open '#{url}'")
	end

	def save
		@@all << self
	end

end
