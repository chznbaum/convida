class CreateAttachments < ActiveRecord::Migration[5.1]
  def change
    create_table :attachments do |t|
      t.references :account, foreign_key: true
      t.references :user, foreign_key: true
      t.string :attachment_upload
      t.string :type, null: false
      t.text :alt
      t.text :caption
      t.integer :status, null: false, default: 0

      t.timestamps
    end
  end
end
