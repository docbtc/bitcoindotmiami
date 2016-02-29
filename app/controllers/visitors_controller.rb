class VisitorsController < ApplicationController

  def index
    @coinbase_price = coinbase_price
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

end
