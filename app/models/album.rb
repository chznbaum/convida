class Album < ApplicationRecord
  belongs_to :account
  belongs_to :user
  has_many :attachments
  accepts_nested_attributes_for :attachments, reject_if: proc { |attrs| attrs['attachment_upload'].blank? && attrs['attachment_upload_cache'].blank? }

  def set_user!(user)
    self.user_id = user.id
    self.save!
  end
  
  def self.by_recent
    order(created_at: :desc, id: :desc)
  end
end
