class UserTopic < ApplicationRecord
  belongs_to :user
  belongs_to :topic
  has_secure_token :token
end
