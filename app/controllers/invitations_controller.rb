class InvitationsController < ApplicationController
  before_action :check_invitation

  def show
    render json: { message: "Welcome Dear #{@current_user.first_name}! , Kindly set your Password to access Accout" , current_user_id: @current_user.id }
  end

  private

  def check_invitation
    token = request.headers['Authorization']&.split(' ')&.last
    decoded = JsonWebToken.decode(token)
    @current_user = User.find(decoded[:user_id]) if decoded
    raise ActiveRecord::RecordNotFound unless @current_user
  rescue
    render json: { errors: ['Not Authenticated'] }, status: :unauthorized
  end
end