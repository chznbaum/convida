class DashboardsController < ApplicationController
  before_action :authenticate_user!
  
  def show
    @attachments = @account.attachments.by_recent
    @albums = @account.albums.by_recent
  end
end
