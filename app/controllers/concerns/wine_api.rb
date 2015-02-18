module WineApi
  extend ActiveSupport::Concern

  class WineCatalog
    include HTTParty
    base_uri 'services.wine.com'

    def initialize()
      @options = { query: {"apikey" => ENV["WINE_API_KEY"]} }
    end

    def search(search_raw)
      # sanitize the search string
      search_string = search_raw.scan(/[\s\w]/).join("")
      search_string = search_string.gsub(" ", "%20")

      # add the search string
      query = @options
      query[:query].merge!({"search" => search_string})

      # API request, execting json response
      response = self.class.get("/beta2/service.svc/JSON/catalog?", query)

      # Only return what's needed, an array of results
      return response["Products"]["List"]
    end

    def id(product_id)
      # add the product id
      query = @options
      query[:query] << {"product" => product_id}

      # API request, execting json response
      self.class.get("/beta2/service.svc/JSON/catalog?", query)
    end
  end
end
