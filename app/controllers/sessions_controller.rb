class SessionsController < Devise::OmniauthCallbacksController

  def facebook
    set_oauth
  end
  
  def google_oauth2
    set_oauth
  end

  private
    def set_oauth
      @user = User.from_omniauth(request.env["omniauth.auth"])
      sign_in @user
      redirect_to gifts_path
    end
end
