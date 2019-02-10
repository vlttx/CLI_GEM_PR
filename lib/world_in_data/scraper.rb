class WorldInData::Scraper

	def initialize (url = nil)
		@url = url
	end

	def scrape_description
		@doc = Nokogiri::HTML(open(@url))
		@doc.css(".article-content p")[0..2].text
	end

	def scrape_articles
		@doc = Nokogiri::HTML(open('https://ourworldindata.org/blog'))
		@doc.css("li.post").each do |scraped_article|
			article = WorldInData::Article.new
			article.title = scraped_article.css("a h3").text.gsub("\u00E2\u0080\u0099", "'").gsub("\u00E2\u0082\u0082", "2")
			article.date = scraped_article.css(".entry-meta time").text
			article.author = scraped_article.css(".entry-meta").children[1].text.gsub(" by ", "")
			article.url = "https://ourworldindata.org#{scraped_article.css("a").attribute("href")}"
			article.save
		end
	end
end









































# def scrape_articles
# 		@doc = Nokogiri::HTML(open('https://ourworldindata.org/blog'))
# 		articles = @doc.css("li.post")
# 		article_hash = {}
# 		articles.collect do |article|
# 		article_hash = {
#   			:title => article.css("a h3").text.gsub("\u00E2\u0080\u0099", "'"),
#   			:date => article.css(".entry-meta time").text,
#   			:author => article.css(".entry-meta").children[1].text.gsub(" by ", ""),
#   			:url => "https://ourworldindata.org#{article.css("a").attribute("href")}"}
# 		end
# 	end