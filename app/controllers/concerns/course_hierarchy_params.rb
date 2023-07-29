module CourseHierarchyParams
  def course_params_schema
    [
      :id,
      :name,
      :state,
      :author
    ]
  end

  def category_params_schema
    [
      :id,
      :name,
      :state,
      courses_attributes: course_params_schema
    ]
  end

  def vertical_params_schema
    [
      :name,
      categories_attributes: category_params_schema
    ]
  end
end