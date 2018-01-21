class DashboardsController < ApplicationController
  before_action :authenticate_user!
  
  def show
    @attachments = @account.attachments.by_recent
  end
end
