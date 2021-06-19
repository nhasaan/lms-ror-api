class UsersController < ApplicationController
  skip_before_action :authorize_request, only: :create
  before_action :set_user, :set_current_user, only: %i[show update destroy]

  # GET /users
  def index
    @users = User.all

    render json: @users
  end

  # GET /users/1
  def show
    render json: @user
  end

  def current_user
    render json: @current_user
  end

  # POST /users
  # def create
  #   @user = User.new(user_params)

  #   if @user.save
  #     render json: @user, status: :created, location: @user
  #   else
  #     render json: @user.errors, status: :unprocessable_entity
  #   end
  # end

  # POST /signup
  # return authenticated token upon signup
  def create
    user = User.create!(user_params)
    auth_token = AuthenticateUser.new(user.email, user.password).call
    response = { message: Message.account_created, auth_token: auth_token }
    json_response(response, :created)
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  def set_current_user
    @current_user = User.find_by(token: request.headers['Authorization'])
  end

  # Only allow a list of trusted parameters through.
  # def user_params
  #   params.require(:user).permit(:name, :email, :password_digest)
  # end

  def user_params
    params.permit(
      :name,
      :email,
      :role,
      :password,
      :password_confirmation
    )
  end
end
