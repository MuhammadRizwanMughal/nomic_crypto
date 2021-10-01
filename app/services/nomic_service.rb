# frozen_string_literal: true

class NomicService
  include HTTParty

  API_KEY  = Rails.application.credentials.api_key
  BASE_URL = 'https://api.nomics.com/v1/'
  ENDPOINT = {
    list_currencies: "/currencies/ticker?key=#{API_KEY}&ids=",
    fiat_currency: "/currencies/sparkline?key=#{API_KEY}&ids="
  }.freeze

  class << self
    def get_currencies(action, params = {})
      ids_query = if params[:ids] == 'All'
                    'BTC,ETH,XRP'
                  elsif params[:ids].instance_of?(String)
                    params[:ids]
                  elsif params[:ids].present?
                    params[:ids].join(',')
                  end

      attribute_query = if params[:attributes].present? && params[:attributes] == 'All'
                          'id,name,max_supply,price'
                        elsif params[:attributes].instance_of?(String)
                          params[:attributes]
                        elsif params[:attributes].present?
                          params[:attributes].join(',')
                        end

      attribute_query = attribute_query.present? ? "&attributes=#{attribute_query}" : ''

      url = "#{BASE_URL}#{ENDPOINT[action]}#{ids_query}#{attribute_query}"
      get_data(url)
    end

    def get_fiat_currency(action, params)
      time_span = '&start=2018-04-14T00%3A00%3A00Z&end=2018-05-14T00%3A00%3A00Z'
      url = "#{BASE_URL}#{ENDPOINT[action]}#{params[:id]}#{time_span}&convert=#{params[:fiat]}"
      get_data(url)
    end

    def get_comparison(btc_value, eth_value, xrp_value)
      {
        "BTC_VALUE": {
          "1BTC": ["#{(btc_value / eth_value).round(8)} ETH", "#{(btc_value / xrp_value).round(8)} XRP"]
        },
        "ETH_VALUE": {
          "1ETH": ["#{(eth_value / btc_value).round(8)} BTC", "#{(eth_value / xrp_value).round(8)} XRP"]
        },
        "XRP_VALUE": {
          "1XRP": ["#{(xrp_value / btc_value).round(8)} BTC", { "1XRP": "#{(xrp_value / eth_value).round(8)} ETH" }]
        }
      }
    end

    private

    def get_data(url)
      # make sure that request use ssl
      options = {
        verify: true
      }
      HTTParty.get(url, options)
    end
  end
end
