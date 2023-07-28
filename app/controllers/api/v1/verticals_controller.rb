module Api
  module V1
    # Api::V1::VerticalsController
    class VerticalsController < ActionController::API
      rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

      before_action :set_vertical, only: :update

      def index
        # TODO: Use ElasticSearch
        verticals = Vertical.all
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
        params.require(:vertical).permit(
          :name,
          categories_attributes: [
            :id,
            :name,
            :state,
            courses_attributes: [
              :id,
              :name,
              :state,
              :author
            ]
          ]
        )
      end

      def record_not_found(*)
        render json: { error: 'Record not found' }, status: :not_found
      end

      def set_vertical
        @vertical = Vertical.find(params[:id])
      end
    end
  end
end
