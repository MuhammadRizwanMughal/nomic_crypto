class NomicService
  include HTTParty

  API_KEY  = 'ca36555a881ed9bfea26574e1a5f587f5f30b2ca'
  BASE_URL = 'https://api.nomics.com/v1/'
  ENDPOINT = {
    list_currencies: "/currencies/ticker?key=#{API_KEY}&ids="
  }

  class << self
    def get_currencies(action, params)
      attribute_query = params[:attributes].present? ? "&attributes=#{params[:attributes]}" : ''
      url = "#{BASE_URL}#{ENDPOINT[action]}#{params[:ids]}#{attribute_query}"
      options = {
        verify: true
      }
      HTTParty.get(url, options)
    end
  end
end
