require 'httparty'
require 'yaml'

module Stackexchange
  class Client
    include HTTParty
    base_uri 'api.stackexchange.com'

    def initialize(options = {})
      @options = { query: {site: 'stackoverflow', page: 1} }
    end

    def tag_info(tags)
      tags_query = case tags
        when Array then tags.join(';')
        when String then tags
        else ""
      end

      raise ArgumentError, 'Argument is not an array' if tags_query.empty?

      responce = self.class.get("/2.2/tags/#{tags_query}/info", @options)
      extract_stats(responce)
    end

    def tag_info_from_yaml(path)
      data = YAML.load_file(path)
      data = data.pop if data.is_a? Array
      if !data["langs"].nil? and data["langs"].is_a? Array
        tag_info(data["langs"])
      else
        raise ArgumentError, "Malformed yaml file"
      end
    end

    private

    def extract_stats(response)
      response.parsed_response["items"].collect { |lang|
        [lang["name"], lang["count"]]
      }.to_h
    end
  end
end
