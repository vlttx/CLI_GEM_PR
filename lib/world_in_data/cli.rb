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
		@input = nil
		while @input != "exit" 
		    @input = gets.strip.upcase
		    if initial_input_checker
		    		after_selection_choices
		    	end
			end
		end

	def display_selected_article
		if @input.to_i-1 >= WorldInData::Article.all.size
			puts ""
			puts "This number is too high. Enter article number from the list above or exit.".colorize(:blue)
			puts ""
		elsif @input.to_i-1 < WorldInData::Article.all.size
			@article = WorldInData::Article.all[@input.to_i-1]
			puts ""
			puts @article.title.colorize(:color => :black, :background => :white)
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
			puts "To exit, enter EXIT".colorize(:blue)
			puts ""
			@input = gets.strip.upcase
		end
	end


	def after_selection_choices
		if @input.upcase == "Y" || @input.upcase == "YES"
			@article.open_in_browser
			puts ""
			puts "To see the list again, type LIST, to exit, type EXIT.".colorize(:blue)
			puts ""
			@input = gets.strip.upcase
			initial_input_checker
		elsif @input == "LIST"
			display_articles
		elsif @input.upcase == "EXIT"
			goodbye_message
		else
			initial_input_checker
		end
	end

	def initial_input_checker
		if @input == "exit" || @input == "EXIT"
			goodbye_message
		elsif @input.upcase == "LIST"
			display_articles
		elsif @input.to_i.to_s != @input
			puts ""
			puts "Your entry is invalid. Please enter a number from the list above.".white.on_red.blink
			puts ""
		elsif @input.to_i-1 > WorldInData::Article.all.size
			puts ""
			puts "This number is too high. Enter article number from the list above or exit.".white.on_red.blink
			puts ""
		elsif @input.to_i-1 <= WorldInData::Article.all.size
			display_selected_article
			after_selection_choices
		elsif @input.upcase == "Y" || @input == "YES"
			after_selection_choices
		else
			puts ""
			puts "Your entry is invalid. Please enter a number from the list above.".white.on_red.blink
			puts ""
			@input = gets.strip
			initial_input_checker
		end
	end

	def goodbye_message
		puts ""
		puts "Goodbye! See you next time!".colorize(:color => :blue, :background => :white)
		puts ""
		exit
	end
end


