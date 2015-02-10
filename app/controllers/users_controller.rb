class UsersController < ApplicationController
  skip_before_action :validate_token, only: [:create]

  # POST /users
  def create
    @user = User.new(user_params)
    if @user.save
      @token = get_auth_token(@user)
      render :create, status: :created
    else
      render json: {errors: @user.errors}, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.permit(:name, :username, :email, :password)
  end
end
