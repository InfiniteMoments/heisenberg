class UsersController < ApplicationController
  skip_before_action :authenticate_request, only: [:create]

  # POST /users
  def create
    @user = User.new(user_params)
    if @user.save
      @token = @user.generate_auth_token
      render :create, status: :created
    else
      render json: {errors: @user.errors}, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :username, :email, :password)
  end
end
