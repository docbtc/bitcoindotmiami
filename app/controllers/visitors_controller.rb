class VisitorsController < ApplicationController

  def index
    require 'coinbase/wallet'
    client = Coinbase::Wallet::Client.new(api_key: <api key>, api_secret: <api secret>)
    price = client.spot_price({currency: 'USD'})
  end

end
