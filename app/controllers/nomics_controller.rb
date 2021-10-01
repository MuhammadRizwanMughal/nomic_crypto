class NomicsController < ApplicationController

  def index;end

  ## task 1 & 2
  def list_currencies
    @data = if params[:ids].present?
      NomicService.get_currencies(:list_currencies, params)
    else
      { status: 400, message: 'ids are required i.e. [BTC, XRP, ETH]'}
    end
  end

  ## task 3
  def fiat_currency
    @data = if params[:id].present? && params[:fiat]
      NomicService.get_fiat_currency(:fiat_currency, params)
    else
      { status: 400, message: 'id and fiat are required i.e. [BTC, XRP, ETH]'}
    end
  end

  ## task 4
  def comparative_currencies
    begin
      response   = NomicService.get_currencies(:list_currencies, { ids: 'All'})
      btc_value  = response[0]['price'].to_f
      eth_value  = response[1]['price'].to_f
      xrp_value  = response[2]['price'].to_f
      comparison = NomicService.get_comparison(btc_value, eth_value, xrp_value)

      @data = {
        currency_values: {
          BTC: btc_value,
          ETH: eth_value,
          XRP: xrp_value
        },
        comparative_values: comparison
      }
    rescue => e
      @data = { status: 200, message: e.full_message }
    end
  end
end
