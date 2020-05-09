class Todo < ApplicationRecord
  belongs_to :topic
  belongs_to :user
  belongs_to :column
  has_rich_text :content
  # validates :title, presence: true
end
