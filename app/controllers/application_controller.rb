class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_currency

  def current_currency
    if session[:current_currency].blank?
      Product::DEFAULT_CURRENCY
    else
      session[:current_currency]
    end
  end
end
