module Verticals
  # Verticals::UpdateService.new(vertical, params).call
  class UpdateService
    def initialize(vertical, params)
      @vertical = vertical
      @params = params
    end

    def call
      @vertical.update(@params)
    end
  end
end
