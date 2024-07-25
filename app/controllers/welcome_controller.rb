class WelcomeController < ApplicationController
  before_action :authenticate_request

  def show
    render json: { message: "Welcome, #{@current_user.email}!" , current_user_id: @current_user.id }
  end
end