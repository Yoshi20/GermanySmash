class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  rescue_from ActionController::InvalidAuthenticityToken, with: :rescue_invalid_auth_token

  before_action :set_locale
  before_action :authenticate_user!, except: [
    :index, :show, :location, :unregistered,
    :nrw, :hessen, :nds, :bayern, :berlin, :norden, :osten, :bawu
  ]
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_paper_trail_whodunnit
  before_action :get_top_players
  before_action :get_next_tournaments
  before_action :prepare_exception_notifier
  after_action :set_response_language_header

  protected

  def configure_permitted_parameters
    #new
    added_attrs = [:username, :email, :password, :password_confirmation,
      :remember_me, :challonge_username, :challonge_api_key, :full_name,
      :mobile_number, :area_of_responsibility, :federal_state, :gender,
      :birth_year, :prefix, :discord_username, :twitter_username,
      :instagram_username, :youtube_video_ids, :allows_emails_from_germanysmash,
      :allows_emails_from_partners]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end

  def user_for_paper_trail
    current_user.try(:username)
  end

  def after_sign_in_path_for(resource)
    if request.referer.nil? or request.referer.include?('/users/')
     root_path
    else
     request.referer
    end
  end

  def after_sign_out_path_for(resource)
    request.referrer
  end

  def get_top_players
    @topPlayers = []
    helpers.top_players_s12_21.each do |p|
      player = Player.find_by(gamer_tag: p)
      player = AlternativeGamerTag.find_by(gamer_tag: p).try(:player) if player.nil?
      @topPlayers << player unless player.nil?
      break if @topPlayers.size >= 12 # limit(12)
    end
  end

  def get_next_tournaments
    @nextTournaments = Tournament.active.upcoming.order(date: :asc).includes(:players).limit(10)
  end

  private
    def set_locale
      if params[:locale].present?
        cookies.permanent[:locale] = params[:locale] if cookies[:cookie_eu_consented] == "true"
      end
      localeCookie = cookies[:locale]
      if localeCookie.present?
        I18n.locale = localeCookie
      else
        I18n.locale = http_accept_language.compatible_language_from(I18n.available_locales)
        cookies.permanent[:locale] = I18n.locale.to_s if cookies[:cookie_eu_consented] == "true"
      end
    end

    def set_response_language_header
        response.headers["Content-Language"] = I18n.locale.to_s
    end

    def prepare_exception_notifier
      request.env["exception_notifier.exception_data"] = {
        current_user: current_user
      }
    end

    def rescue_invalid_auth_token
      redirect_to new_user_session_path, alert: t('flash.alert.login_failed')
    end

end
