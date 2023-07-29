module Categories
  # Categories::UpdateService.new(category, params).call
  class UpdateService
    def initialize(category, params)
      @category = category
      @params = params
    end

    def call
      @category.update(@params)
    end
  end
end
