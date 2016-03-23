class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :init

  def init
    @coinbase_price = coinbase_price
    @meetup_event = meetup_event
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
      image = targs[1].split("\" />") rescue ["http://www.andybarratt.co.uk/wp-content/uploads/2013/08/Bitcoin-Coin-1024.jpg"]
      result = { url: result["event_url"], name: result["name"], location: "#{result['venue']['name']}, #{result['venue']['address_1']}, #{result['venue']['city']}", image: "#{image[0]}" }
      results_set.push(result) if results_set.length < 6
    end

    bitcoin_meetup = HTTParty.get "https://api.meetup.com/2/events?&sign=true&photo-host=public&fields=self&group_urlname=Code-for-Miami&page=20"
    bitcoin_meetup["results"].each do |result|
      targs = result["description"].split("<img src=\"")
      image = targs[1].split("\" />") rescue ["http://www.andybarratt.co.uk/wp-content/uploads/2013/08/Bitcoin-Coin-1024.jpg"]
      result = { url: result["event_url"], name: result["name"], location: "#{result['venue']['name']}, #{result['venue']['address_1']}, #{result['venue']['city']}", image: "#{image[0]}" }
      results_set.push(result) if results_set.length < 6
    end

    return results_set
  end

end
