class DashboardsController < ApplicationController
  before_action :authenticate_user!
  
  def show
    @account = { account: Account.includes(:attachments, albums: :attachments).find_by(subdomain: request.subdomain).serializable_hash(include: [:attachments, albums: { include: :attachments }]) }[:account]
    @attachments = @account['attachments']
    @albums = @account['albums']
  end
end
