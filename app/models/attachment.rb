class Attachment < ApplicationRecord
  validates_presence_of :attachment_upload, :status, :content_type

  mount_uploader :attachment_upload, AttachmentUploader

  enum status: { "Pending" => 0, "Approved" => 1 }

  belongs_to :account
  belongs_to :user

  def set_user!(user)
    self.user_id = user.id
    self.save!
  end

  def self.by_recent
    order(created_at: :desc, id: :desc)
  end
end
