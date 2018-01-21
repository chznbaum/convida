class AddAlbumToAttachments < ActiveRecord::Migration[5.1]
  def change
    add_reference :attachments, :album, foreign_key: true
  end
end
