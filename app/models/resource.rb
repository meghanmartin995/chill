class Resource < ApplicationRecord
  belongs_to :topic
  belongs_to :user
  validates :title, presence: true
end
