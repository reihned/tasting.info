module WineAPI
  extend ActiveSupport::Concern

  class WineServices
    include HTTParty
    base_uri 'services.wine.com'
    @api_key = ENV["WINE_API_KEY"]

    def initialize()
      @options = { query: {"apikey" => @api_key} }
    end

    def search(search_raw)
      # sanitize the search string
      search_string = search_raw.scan(/[\s\w]/);
      search_string = search_string.gsub(" ", "%20")

      # add the search string
      query = @options
      query[:query] << {"search" => search_string}

      # API request
      self.class.get("/beta2/service.svc/JSON/catalog?", query)
    end

    def id(product_id)
      # add the product id
      query = @options
      query[:query] << {"search" => search_string}

      # API request
      self.class.get("/beta2/service.svc/JSON/catalog?", query)
    end
  end
end
