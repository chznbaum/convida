class Album < ApplicationRecord
  include ActiveModel::Serializers::JSON
  belongs_to :account
  belongs_to :user
  has_many :attachments
  accepts_nested_attributes_for :attachments, reject_if: proc { |attrs| attrs['attachment_upload'].blank? && attrs['attachment_upload_cache'].blank? }
  
  def self.by_recent
    order(created_at: :desc, id: :desc)
  end
end
