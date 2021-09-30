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
end
