class Child < ApplicationRecord
  belongs_to :account
  has_many :child_tags, dependent: :destroy
  has_many :attachments, through: :child_tags

  validates :pronoun, inclusion: { in: PRONOUNS }
end
