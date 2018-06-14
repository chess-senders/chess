class Players::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def facebook
    # You need to implement the method below in your model (e.g. app/models/player.rb)
    @player = Player.from_omniauth(request.env["omniauth.auth"])

    if @player.persisted?
      sign_in_and_redirect @player
      set_flash_message(:notice, :success, kind: "Facebook") if is_navigational_format?
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      redirect_to new_player_registration_url
    end
  end

  def google_oauth2
      # You need to implement the method below in your model (e.g. app/models/player.rb)
      @player = Player.from_omniauth(request.env['omniauth.auth'])

      if @player.persisted?
        flash[:notice] = I18n.t 'devise.omniauth_callbacks.success', kind: 'Google'
        sign_in_and_redirect @player, event: :authentication
      else
        session['devise.google_data'] = request.env['omniauth.auth'].except(:extra) # Removing extra as it can overflow some session stores
        redirect_to new_player_registration_url, alert: @player.errors.full_messages.join("\n")
      end
  end

  def failure
    redirect_to root_path
  end
end
