class NomicsController < ApplicationController

  def index
  end

  ## task 1 & 2
  def list_currencies
    response = if params[:ids].present?
      NomicService.get_currencies(:list_currencies, params)
    else
      { status: 400, message: 'ids are required i.e. [BTC, XRP, ETH]'}
    end
    render json: response
  end
end
