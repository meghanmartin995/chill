class Column < ApplicationRecord
  belongs_to :user
  belongs_to :topic
  has_many :todos, dependent: :destroy
  validates :title, presence: true
end
