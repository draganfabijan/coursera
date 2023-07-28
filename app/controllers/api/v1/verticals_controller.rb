module Api
  module V1
    # Api::V1::VerticalsController
    class VerticalsController < ApplicationController
      def index
        # TODO: Use ElasticSearch
        verticals = Vertical.all
        render json: verticals
      end
    end
  end
end
