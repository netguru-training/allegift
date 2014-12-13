class SessionsController < Devise::OmniauthCallbacksController
  before_action :set_oauth, only: [:facebook, :google_oauth2]
  def facebook
    set_oauth
  end
  def google_oauth2
    set_oauth
  end

  private
    def set_oauth
      @user = User.from_omniauth(request.env["omniauth.auth"])
      sign_in_and_redirect @user
    end
end
