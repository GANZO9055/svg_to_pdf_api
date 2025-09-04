class ApplicationController < ActionController::API
  rescue_from StandardError do |exception|
    render json: { errors: [{ detail: exception.message }] }, status: :internal_server_error
  end
end
