class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  skip_before_action :verify_authenticity_token, only: :github
  def vkontakte
    omniauth_callback('Vkontakte')
  end

  def github
    omniauth_callback('GitHub')
  end

  protected
  
  def omniauth_callback(kind)
    @user = User.find_for_oauth(request.env['omniauth.auth'])
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: kind) if is_navigational_format?
  end
end
