class Topic < ApplicationRecord
  has_many :todos, dependent: :destroy
  has_many :resources, dependent: :destroy
  validates :title, presence: true
  validates :color, presence: true
  belongs_to :user
end
