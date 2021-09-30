class NomicService
  include HTTParty

  API_KEY  = 'set-api-key'
  BASE_URL = 'https://api.nomics.com/v1/'
  ENDPOINT = {
    list_currencies: "/currencies/ticker?key=#{API_KEY}&ids=",
    fiat_currency: "/currencies/sparkline?key=#{API_KEY}&ids="
  }

  class << self
    def get_currencies(action, params)
      ids_query = if params[:ids] == 'All'
        "BTC,ETH,XRP"
      elsif params[:ids].class.name == 'String'
        params[:ids]
      else 
        params[:ids].join(',')
      end

      attribute_query = if params[:attributes].present? && params[:attributes] == 'All'
        "id,name,max_supply,price"
      elsif params[:attributes].class.name == 'String'
        params[:attributes]
      elsif params[:attributes].present?
        params[:attributes].join(',')
      end

      attribute_query = attribute_query.present? ? "&attributes=#{attribute_query}" : ''

      url = "#{BASE_URL}#{ENDPOINT[action]}#{ids_query}#{attribute_query}"
      # make sure that request use ssl
      options = {
        verify: true
      }
      HTTParty.get(url, options)
    end

    def get_fiat_currency(action, params)
      time_span = "&start=2018-04-14T00%3A00%3A00Z&end=2018-05-14T00%3A00%3A00Z"      
      url = "#{BASE_URL}#{ENDPOINT[action]}#{params[:id]}#{time_span}&convert=#{params[:fiat]}"
      # make sure that request use ssl
      options = {
        verify: true
      }
      HTTParty.get(url, options)
    end
  end
end
