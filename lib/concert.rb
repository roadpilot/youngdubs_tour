class Concert
  attr_accessor :id, :title, :date_start, :time_end, :street_addr, :locality, :region, :event_url
  @@all = []

  def initialize(attributes)
      attributes.each do |attribute_name, attribute_value|
          self.send("#{attribute_name}=", attribute_value)
      end
      @@all << self
  end

  def self.all
    @@all
  end

  def self.print_titles
    all.each_with_index do |concert, index|
      puts "#{index+1}. #{concert.title}"
    end
  end

  def self.detail_by_id(id)
    detail = @@all[id.to_i-1]
    print "\r" + id + ". " + detail.title
    print "\n" + detail.date_start
    print " - " + detail.time_end
    print "\nAddress:    " + detail.street_addr
    print "\n            " + detail.locality
    print ", " + detail.region
    print "\nEvent URL:  " + detail.event_url + "\n"
  end
  
end
