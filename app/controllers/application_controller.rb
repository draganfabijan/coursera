class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ActiveRecord::RecordNotUnique, with: :record_not_unique

  private

  def record_not_found
    render json: { error: 'Record not found' }, status: :not_found
  end

  def record_not_unique
    render json: { error: 'Record already exists' }, status: :unprocessable_entity
  end
end