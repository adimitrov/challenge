require 'httparty'

module Wolfram
  class Client
    include HTTParty
    base_uri 'api.wolframalpha.com'

    def initialize(options = {})
      @options = { query: { appid: options[:appid] } }
    end

    def influenced(languages)
      languages_query = case languages
        when Array then languages.join(',')
        when String then "#{languages} programming language"
        else ""
      end

      raise ArgumentError, 'Invalid language' if languages_query.empty?
      @options[:query][:input] = languages_query

      response = self.class.get("/v2/query", @options)
      parse_response(response)
    end

    def parse_response response
      if response["queryresult"]["error"][0] == 'true'
        raise ArgumentError, response["queryresult"]["error"][1]["msg"]
      end

      # Select the right cell and strip
      languages = response["queryresult"]["pod"][1]["subpod"]["plaintext"]
        .split("\n")
        .select { |row| row.to_s.start_with? 'languages influenced' }
        .first
        .split('|')
        .drop(1)
        .map(&:strip)

        normalize_languages languages
    end

    def normalize_languages(languages)
      languages.map { |item| item.gsub('Windows ', '') }
        .map { |item| item.gsub(' ', '-') }
        .map(&:downcase)
    end

    def influenced_from_yaml(path)
      data = YAML.load_file(path)
      data = data.pop if data.is_a? Array
      if !data["langs"].nil? and data["langs"].is_a? Array
        influenced(data["langs"])
      else
        raise ArgumentError, "Malformed yaml file"
      end
    end
  end
end
