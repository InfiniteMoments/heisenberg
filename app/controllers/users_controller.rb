class UsersController < ApplicationController
  skip_before_action :validate_token, only: :create
  before_action :correct_user, only: :update

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

  # GET /users/:id
  def show
    @user = User.find(params[:id])
  end

  # PATCH /users/:id
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_update_params)
      render :show
    else
      render json: {errors: @user.errors}, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.permit(:name, :username, :email, :password)
  end

  def user_update_params
    params.permit(:name, :email, :password)
  end

  def correct_user
    @user = User.find(params[:id])
    render json: {error: 'Forbidden'}, status: :forbidden unless current_user?(@user)
  end

end
