module Courses
  # Courses::UpdateService.new(course, params).call
  class UpdateService
    def initialize(course, params)
      @course = course
      @params = params
    end

    def call
      @course.update(@params)
    end
  end
end
