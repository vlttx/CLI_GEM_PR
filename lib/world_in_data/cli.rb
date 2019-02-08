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
		while input != "exit" && input != "EXIT" 
		input = gets.strip 
			if input == "exit" || input == "EXIT"
				puts ""
				puts "Goodbye! See you next time!".colorize(:blue)
				puts ""
			elsif  input.to_i.to_s != input
				puts ""
				puts "Your entry is invalid. Please enter a number from the list above.".colorize(:blue)
				puts ""
			elsif input.to_i-1 > WorldInData::Article.all.size
				puts ""
				puts "This number is too high. Enter article number from the list above or exit.".colorize(:blue)
				puts ""
			elsif input.to_i-1 <= WorldInData::Article.all.size
				article = WorldInData::Article.all[input.to_i-1]
				puts ""
				puts article.title.colorize(:color => :blue, :background => :white)
				puts ""
				puts article.content_description
				puts ""
				puts "Author(s): #{article.author}"
				puts ""
				puts "Posting date: #{article.date}" 
				puts ""
				
				puts "Prefer to see the full article and data visualization? Enter Y or YES to open in your browser.".colorize(:blue)
				puts ""
				puts "To go back to the list, enter LIST.".colorize(:blue)
				puts ""
				puts "To exit, enter EXIT".colorize(:blue)

				input = gets.strip.upcase

				if input == "Y" || input == "YES"
					article.open_in_browser
				elsif input == "LIST"
					display_articles
				elsif input == "EXIT"
					exit

				else
					puts "I don't understand what you entered, please try again.".colorize(:blue)
					puts "If you would to see the full article and data visualization, enter Y or YES.".colorize(:blue)
					puts "To go back to the list, enter LIST.".colorize(:blue)
					puts "To exit, enter EXIT".colorize(:blue)
				end
			end
		end
	end
end