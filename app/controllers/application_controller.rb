class ApplicationController < ActionController::API
  include ActionController::Serialization

  before_action :set_locale

  def set_locale
    if params[:locale]
      Globalize.locale = params[:locale]
    end
  end
end