class WorldInData::CLI


	def call
		puts ""
		puts "Welcome to the World In Data!".colorize(:color => :blue, :background => :white)
		puts "Here are the most recent articles:".colorize(:color => :blue, :background => :white)
		WorldInData::Scraper.new.scrape_articles
		display_articles
		puts ""
		menu	
	end


	def display_articles
		puts ""
		WorldInData::Article.all.each_with_index do |article, i|
			puts "#{i+1}. #{article.title}"
		end
		puts ""
		puts "Which article would you like to read today?".colorize(:color => :blue, :background => :white)
		puts "Please enter its number:".blue.on_white.blink
		puts ""
	end

	def menu
		input = nil
		while input != "exit"
			input = gets.strip
			if input.to_i-1 <= WorldInData::Article.all.size
				article = WorldInData::Article.all[input.to_i-1]
				puts ""
				puts article.title.colorize(:color => :blue, :background => :white)
				puts ""
				puts WorldInData::Article.content_description(article.url)
				puts ""
				puts "Author(s): #{article.author}"
				puts ""
				puts "Posting date: #{article.date}" 
				puts ""
				
				puts "Prefer to see the full article and data visualization? Enter Y or YES to open in your browser.".colorize(:blue)
				puts ""
				puts "To go back to the list, enter N or NO.".colorize(:blue)
				puts "To exit, enter EXIT".colorize(:blue)

				answer = gets.strip.upcase

				if answer == "Y" || answer == "YES"
					article.open_in_browser
				elsif answer == "N" || answer == "NO"
					display_articles
				elsif answer == "EXIT"
					exit
				else
					puts "I don't understand what you entered, please try again.".colorize(:blue)
					puts "If you would to see the full article and data visualization, enter Y or YES.".colorize(:blue)
					puts "To go back to the list, enter N or NO.".colorize(:blue)
					puts "To exit, enter EXIT".colorize(:blue)
				end
			end
		end
	end


end