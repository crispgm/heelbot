module Heel
  class Response

    attr_accessor :body

    def initialize(body = {})
      @body = body
    end

    def as_json
      require "json"

      JSON.generate(@body)
    end

    def as_s
      @body.to_s
    end

    def as_raw
      @body
    end
  end
end