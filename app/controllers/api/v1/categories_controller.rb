module Api
  module V1
    # Api::V1::CategoriesController
    class CategoriesController < ApplicationController
      include CourseHierarchyParams

      before_action :set_category, only: :update

      def index
        # TODO: Add pagination
        categories = Category.search('*').results
        render json: categories
      end

      def update
        if Categories::UpdateService.new(@category, category_params).call
          render json: @category
        else
          render json: @category.errors, status: :unprocessable_entity
        end
      end

      private

      def category_params
        params.require(:category).permit(*category_params_schema)
      end

      def set_category
        @category = Category.find(params[:id])
      end
    end
  end
end
