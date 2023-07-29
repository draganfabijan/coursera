module Api
  module V1
    # Api::V1::VerticalsController
    class VerticalsController < BaseController
      before_action :set_vertical, only: :update

      def index
        # TODO: Add pagination
        verticals = Vertical.search('*', load: false).results
        render json: verticals
      end

      def update
        if Verticals::UpdateService.new(@vertical, vertical_params).call
          render json: @vertical
        else
          render json: @vertical.errors, status: :unprocessable_entity
        end
      end

      private

      def vertical_params
        params.require(:vertical).permit(*vertical_params_schema)
      end

      def set_vertical
        @vertical = Vertical.find(params[:id])
      end

    end
  end
end
