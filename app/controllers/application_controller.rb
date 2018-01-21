class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :redirect_to_subdomain
  before_action :set_account

  private

  def require_account!
    redirect_to root_url(subdomain: "www") if @account.nil?
  end

  def set_account
    @account = Account.find_by(subdomain: request.subdomain)
  end

  def redirect_to_subdomain
    return unless user_signed_in?

    if request.subdomain.blank?
      if current_user.accounts.any?
        redirect_to root_url(subdomain: current_user.accounts.first.subdomain)
      end
    else
      unless current_user.accounts.pluck(:subdomain).include?(request.subdomain)
        redirect_to root_url(subdomain: current_user.accounts.first.subdomain)
      end
    end
  end
end
