class ChangeAttachmentUploadTypeInAttachments < ActiveRecord::Migration[5.1]
  def change
    remove_column :attachments, :attachment_upload
    add_column :attachments, :attachment_upload, :json
  end
end
