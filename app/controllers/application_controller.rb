class ApplicationController < ActionController::Base
  before_action :set_locale_from_params

  def default_url_options
    { host: ENV['DOMAIN'] || 'localhost:3000', locale: I18n.locale }
  end

  protected

  def set_locale_from_params
    if params[:locale]
      if I18n.available_locales.map(&:to_s).include?(params[:locale])
        I18n.locale = params[:locale]
      else
        flash.now[:notice] = "La traduction en #{params[:locale]} n'est pas disponible"
      end
    else
      I18n.locale = I18n.default_locale
    end
  end
end
