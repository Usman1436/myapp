class ApplicationController < ActionController::API

  def authenticate_request
    token = request.headers['Authorization']&.split(' ')&.last
    decoded = JsonWebToken.decode(token)
    @current_user = User.find(decoded[:user_id]) if decoded
    raise ActiveRecord::RecordNotFound unless @current_user

    # Generate a new token and set it in the response headers
    new_token = JsonWebToken.encode(user_id: @current_user.id)
    response.set_header('Authorization', "Bearer #{new_token}")
  rescue
    render json: { errors: ['Not Authenticated'] }, status: :unauthorized
  end
end
