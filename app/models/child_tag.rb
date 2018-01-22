class ChildTag < ApplicationRecord
  belongs_to :account
  belongs_to :child
  belongs_to :attachment
end
