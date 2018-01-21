class AttachmentsController < ApplicationController
  before_action :require_account!
  before_action :authenticate_user!

  def new
    @attachment = @account.attachments.new
  end

  def create
    @attachment = @account.attachments.new(attachment_params)

    if @attachment.save
      redirect_to subdomain_root_url, notice: 'Attachment was successfully saved.'
    else
      render :new
    end
  end

  private

  def attachment_params
    params.require(:attachment).permit(:user_id, :account_id, :attachment_upload, :content_type, :alt, :caption, :status, :attachment_upload_cache)
  end
end
