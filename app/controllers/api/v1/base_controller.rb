module Api
  module V1
    class BaseController < ApplicationController
      include CourseHierarchyParams
    end
  end
end
