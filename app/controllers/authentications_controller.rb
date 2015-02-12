class AuthenticationsController < ApplicationController
  skip_before_action :validate_token, only: :create

  def create
    @user = User.find_by(username: params[:username].downcase)
    if @user && @user.authenticate(params[:password])
      @token = get_auth_token(@user)
      render :create, status: :created
    else
      render json: {error: 'Invalid username or password'}, status: :unauthorized
    end
  end

  def destroy
    # TODO Not final implementation
    render json: {}
  end
end
