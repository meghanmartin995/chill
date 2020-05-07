class Todo < ApplicationRecord
  belongs_to :topic
  belongs_to :user
end
