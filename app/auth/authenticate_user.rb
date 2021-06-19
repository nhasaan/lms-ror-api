# app/auth/authenticate_user.rb
class AuthenticateUser
  def initialize(email, password)
    @email = email
    @password = password
  end

  # Service entry point
  def call
    data = { user_id: user.id, name: user.name, email: user.email, role: user.role } if user
    access_token = JsonWebToken.encode(data)
    data[:token] = access_token
    data
  end

  private

  attr_reader :email, :password

  # verify user credentials
  def user
    user = User.find_by(email: email)
    return user if user && user.authenticate(password)

    # raise Authentication error if credentials are invalid
    raise(ExceptionHandler::AuthenticationError, Message.invalid_credentials)
  end
end
