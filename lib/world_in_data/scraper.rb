class WorldInData::Scraper

	def initialize (url = nil)
		@url = url
	end

	def scrape_articles
		@doc = Nokogiri::HTML(open('https://ourworldindata.org/blog'))
		articles = page.css("li.post")
		article_hash = {}
		articles.collect do |article|
		article_hash = {
  			:title => article.css("a h3").text.gsub("\u00E2\u0080\u0099", "'"),
  			:date => article.css(".entry-meta time").text,
  			:author => article.css(".entry-meta").children[1].text.gsub(" by ", ""),
  			:url => "https://ourworldindata.org#{article.css("a").attribute("href")}"}
		end
	end
end