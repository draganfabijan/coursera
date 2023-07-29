module Api
  module V1
    # Api::V1::CoursesController
    class CoursesController < ApplicationController
      include CourseHierarchyParams

      before_action :set_course, only: :update

      def index
        # TODO: Add pagination
        courses = Course.search('*').results
        render json: courses
      end

      def update
        if Courses::UpdateService.new(@course, course_params).call
          render json: @course
        else
          render json: @course.errors, status: :unprocessable_entity
        end
      end

      private

      def course_params
        params.require(:course).permit(course_params_schema)
      end

      def set_course
        @course = Course.find(params[:id])
      end
    end
  end
end
