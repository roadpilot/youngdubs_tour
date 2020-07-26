require_relative "../lib/youngdubs_tour/version"
require 'nokogiri'
require 'open-uri'

module YoungdubsTour
  class Error < StandardError; end

  # Your code goes here...
  class CLI

    def start
      system("clear")
      puts "Please wait..."
      self.scrape("https://www.youngdubliners.com/events/")
      system("clear")
      # puts html
      # puts html.css(".tribe-event-url").text

      puts "Welcome to Young Dubliners tour dates."
      list
      loop
    end

    def scrape(url)
      html=Nokogiri::HTML(open(url))
      @list=html.css(".tribe-event-url")
      @details=html.css(".tribe-events-event-meta")
    end

    def list
      puts "These are the current upcoming tour dates and locations:"
      @list.each_with_index {|event,i|
        puts "  #{i+1}. #{event.text.strip}"
      }
      puts ""
    end

    def loop
      a=""
      notice1="Please enter an event number to see event details"
      notice2=", 'list' to see the event list or 'end' to leave..."
      puts notice1 + notice2
      until a=="end"
        a=gets.chomp.downcase
        case
          when a=="list"
            # puts list.text
            list
            puts notice1 + notice2
          when a.to_i>@list.size
            puts "Please choose a number between 1 and #{@list.size} to see event details" + notice2
          when a.to_i.between?(1,@list.size)
            # puts @details[a.to_i-1].css("location").css(".tribe-events-venue-details")
            print "\r" + a + ". " + @list[a.to_i-1].text.strip
            print "\n" + @details[a.to_i-1].css(".location").css(".tribe-event-schedule-details").css(".tribe-event-date-start").text.strip
            print " - " + @details[a.to_i-1].css(".location").css(".tribe-event-schedule-details").css(".tribe-event-time").text.strip
            print "\nAddress:    " + @details[a.to_i-1].css(".location").css(".tribe-events-venue-details").css(".tribe-street-address").text.strip
            print "\n            " + @details[a.to_i-1].css(".location").css(".tribe-events-venue-details").css(".tribe-locality").text.strip.chomp
            print ", " + @details[a.to_i-1].css(".location").css(".tribe-events-venue-details").css(".tribe-region").text.strip
            puts "            " + @details[a.to_i-1].css(".location").css(".tribe-events-venue-details").css(".tribe-gmap").text.strip
            # puts @details[a.to_i-1].css("location").css(".tribe-event-schedule-details").text.strip
            # puts @details[a.to_i-1].css("location").css(".tribe-events-venue-details").text.strip
            puts "Event URL:  " + @list[a.to_i-1]['href']
            puts ""
            puts notice1 + notice2
          when a=="end"
            puts "May the road rise up to meet you\nMay the wind be always at your back\nMay the sun shine warm upon your face\nUntil we meet again..."
          else
            puts "'Tis only a stepmother would blame you.  Please choose a number between 1 and #{@list.size} to see event details" + notice2
          end
        end
    end

  end

end

