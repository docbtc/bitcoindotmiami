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
    bitcoin_meetup = HTTParty.get "https://api.meetup.com/2/events?&sign=true&photo-host=public&fields=self&group_urlname=Bitcoin-of-South-Florida&page=20"
    results_set = []
    bitcoin_meetup["results"].each do |result|
      targs = result["description"].split("<img src=\"")
      image = targs[1].split("\" />")
      result = { name: result["name"], location: "#{result['venue']['name']}, #{result['venue']['address_1']}, #{result['venue']['city']}", image: "#{image[0]}" }
      results_set.push(result)
    end

    return results_set
  end

end
