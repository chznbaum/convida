class AccountsController < ApplicationController
  def new
    @account = Account.new
    @account.owner = User.new #!
  end

  def create
    @account = Account.new(account_params)
    @account.owner = User.new(user_params)

    if @account.save
      redirect_to root_url
    else
      render :new
    end
  end

  private

  def account_params
    params.require(:account).permit(:name, :subdomain)
  end

  def user_params
    params.require(:account).require(:owner_attributes).permit(:email, :first_name, :last_name, :password, :password_confirmation)
  end
end
