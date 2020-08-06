module YoungdubsTour
  class Error < StandardError; end

  # Your code goes here...
  class CLI

    def starter
      system("clear")
      puts "Please wait..."
      Scraper.scrape
      system("clear")
      puts "Welcome to Young Dubliners tour dates."
      Concert.print_titles
      looper
    end

    def looper
      a = ""
      notice1 = "\nPlease enter an event number to see event details"
      notice2 = ", 'list' to see the event list or 'end' to leave..."
      puts notice1 + notice2
      until a == "end"
        a = gets.chomp.downcase
        case
          when a == "list"
            Concert.print_titles
            puts notice1 + notice2
          when a.to_i > Concert.all.size
            puts "Please choose a number between 1 and #{Concert.all.size} to see event details" + notice2
          when a.to_i.between?(1,Concert.all.size)
            Concert.detail_by_id(a)
            puts notice1 + notice2
          when a == "end"
            puts "May the road rise up to meet you\nMay the wind be always at your back\nMay the sun shine warm upon your face\nUntil we meet again..."
          else
            puts "'Tis only a stepmother would blame you.  Please choose a number between 1 and #{Concert.all.size} to see event details" + notice2
          end
        end
    end

  end

end