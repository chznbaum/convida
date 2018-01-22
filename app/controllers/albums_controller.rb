class AlbumsController < ApplicationController
  before_action :set_account
  before_action :require_account!
  before_action :authenticate_user!

  def show
    @album = @account.albums.includes(:attachments).find(params[:id])
  end

  def new
    @album = @account.albums.new
    4.times { @album.attachments.build }
  end

  def create
    @album = @account.albums.new(album_params)

    if @album.save
      redirect_to subdomain_root_url, notice: 'Attachment was successfully saved.'
    else
      render :new
    end
  end

  private

  def set_account
    @account = Account.find_by(subdomain: request.subdomain)
  end

  def album_params
    params.require(:album).permit(:user_id, :title, :description, attachments_attributes: [:id, :user_id, :account_id, :attachment_upload, :content_type, :alt, :caption, :status])
  end
end
