class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :init

  def init
    @coinbase_price = coinbase_price
    @meetup_event = meetup_event
    @news = news
    @leaflet_tiles = leaflet_tiles

  end

  def coinbase_price
    begin
      response = JSON.parse(HTTParty.get("https://api.coinbase.com/v2/prices/spot").body)
      @cb_price = response["data"]["amount"]
      return @cb_price
    rescue
      return 0
    end
  end

  def leaflet_tiles
    results_set = []

    coinmap = HTTParty.get "https://coinmap.org/api/v1/venues"
    coinmap["venues"].each do |result|
      result = { name: result["name"], lat: result["lat"], lon: result["lon"], category: result["category"]  }
      results_set.push(result) if (result[:lon] > -82 && result[:lat] < 28 && result[:lon] < -79 && result[:lat] > 24)
    end

    return results_set
  end

  def meetup_event
    results_set = []
    bitcoin_meetup = HTTParty.get "https://api.meetup.com/2/events?&sign=true&photo-host=public&fields=self&group_urlname=Bitcoin-of-South-Florida&page=20"
    bitcoin_meetup["results"].each do |result|
      targs = result["description"].split("<img src=\"")
      image = targs[1].split("\" />") rescue ["http://www.andybarratt.co.uk/wp-content/uploads/2013/08/Bitcoin-Coin-1024.jpg"]
      result = { url: result["event_url"], name: result["name"], location: "#{result['venue']['name']}, #{result['venue']['address_1']}, #{result['venue']['city']}", image: "#{image[0]}" }
      results_set.push(result) if results_set.length < 6
    end

    bitcoin_meetup = HTTParty.get "https://api.meetup.com/2/events?&sign=true&photo-host=public&fields=self&group_urlname=Refresh-Miami&page=20"
    bitcoin_meetup["results"].each do |result|
      targs = result["description"].split("<img src=\"")
      image = targs[1].split("\" />") rescue ["https://unsplash.it/700/450/?random", "https://unsplash.it/g/700/450/"]
      result = { url: result["event_url"], name: result["name"], location: "#{result['venue']['name']}, #{result['venue']['address_1']}, #{result['venue']['city']}", image: "#{image[0]}" }
      results_set.push(result) if results_set.length < 6
    end

    bitcoin_meetup = HTTParty.get "https://api.meetup.com/2/events?&sign=true&photo-host=public&fields=self&group_urlname=Code-for-Miami&page=20"
    bitcoin_meetup["results"].each do |result|
      targs = result["description"].split("<img src=\"")
      image = targs[1].split("\" />") rescue ["https://unsplash.it/700/450/?random", "https://unsplash.it/g/700/450/"]
      result = { url: result["event_url"], name: result["name"], location: "#{result['venue']['name']}, #{result['venue']['address_1']}, #{result['venue']['city']}", image: "#{image.sample}" }
      results_set.push(result) if results_set.length < 6
    end

    return results_set
  end

  def news
       rss_results = []
       rss = RSS::Parser.parse(open('http://feeds.feedburner.com/CoinDesk?format=xml').read, false).items[0..5]
       rss.each do |result|
         result = { title: result.title, date: result.pubDate, link: result.link, description: result.description }
         rss_results.push(result)
       end
      return rss_results
  end
end
