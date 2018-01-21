class ChangeAttachmentColumnName < ActiveRecord::Migration[5.1]
  def change
    rename_column :attachments, :type, :content_type
  end
end
