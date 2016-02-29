class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :init

  def init
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
