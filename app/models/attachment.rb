class Attachment < ApplicationRecord
  include ActiveModel::Serializers::JSON
  validates_presence_of :attachment_upload, :status

  mount_uploader :attachment_upload, AttachmentUploader

  enum status: { "Pending" => 0, "Approved" => 1 }

  belongs_to :account
  belongs_to :user
  belongs_to :album, optional: true
  has_many :child_tags, dependent: :destroy
  has_many :children, through: :child_tags

  def self.by_recent
    order(created_at: :desc, id: :desc)
  end
end
