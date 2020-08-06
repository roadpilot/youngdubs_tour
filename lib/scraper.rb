class Scraper

    def self.scrape
        html = Nokogiri::HTML(open("https://www.youngdubliners.com/events/"))
        @details=html.css(".tribe-events-event-meta")
        i=0
        html.css(".tribe-event-url").collect { |event|
            @details=html.css(".tribe-events-event-meta")
            concert_info = {
            :id => i,
            :title => event.text.strip,
            :date_start => @details[i].css(".location").css(".tribe-event-schedule-details").css(".tribe-event-date-start").text.strip,
            :time_end => @details[i].css(".location").css(".tribe-event-schedule-details").css(".tribe-event-time").text.strip,
            :street_addr => @details[i].css(".location").css(".tribe-events-venue-details").css(".tribe-street-address").text.strip,
            :locality => @details[i].css(".location").css(".tribe-events-venue-details").css(".tribe-locality").text.strip.chomp,
            :region => @details[i].css(".location").css(".tribe-events-venue-details").css(".tribe-region").text.strip,
            :event_url => event['href']
            }
            i+=1
            Concert.new(concert_info)
        }
    end
  
end