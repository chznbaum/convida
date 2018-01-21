class Album < ApplicationRecord
  belongs_to :account
  belongs_to :user
  has_many :attachments
  accepts_nested_attributes_for :attachments

  def attachments_for_form
    collection = attachments.where(album_id: id)
    collection.any? ? collection : attachments.build
  end

  def set_user!(user)
    self.user_id = user.id
    self.save!
  end
  
  def self.by_recent
    order(created_at: :desc, id: :desc)
  end
end
