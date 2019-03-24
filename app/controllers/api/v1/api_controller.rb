class Api::V1::ApiController < ActionController::Base
#   include DeviseTokenAuth::Concerns::SetUserByToken
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  before_action :authenticate_user!  
  skip_before_action :verify_authenticity_token

  def render_error(message, status)
    status_code = Rack::Utils::SYMBOL_TO_STATUS_CODE[status]
    render json: {error: {status: status_code, message: message}},
           status: status
  end

  def not_found
    render_error(I18n.t('errors.messages.not_found'), :not_found)
  end

  def user_signed_in?
    current_user.present?
  end

  def authenticate_user!
    if request.headers['access-token'].blank? || request.headers['uid'].blank? || !user_signed_in?
      render json: {message: 'Please signin or signup/ Pass valid access-token and uid in headers'}, status: 401
    end
  end

  def current_user
    user = User.find_by_email(request.headers['uid'])
    @current_user ||= ((user && user.validate_token?(request.headers['access-token'])) ? user : nil)
  end

end
