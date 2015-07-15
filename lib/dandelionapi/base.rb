# encoding: UTF-8

module Dandelionapi
  module Base

    class Request

      protected

      def call(endpoint, params)
        begin
          params = params.merge(
            :$app_id => Dandelionapi.config.app_id,
            :$app_key => Dandelionapi.config.app_key
          )
          conn = Faraday.new(url: Dandelionapi.config.endpoint) do |faraday|
            faraday.request  :url_encoded
            faraday.adapter  Faraday.default_adapter
          end
          response = conn.post "#{Dandelionapi.config.path}#{endpoint}", params
          JSON.parse response.body
        rescue Exception => e
          raise Dandelionapi::BadResponse
        end
      end

    end

  end
end