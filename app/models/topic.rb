class Topic < ApplicationRecord
  belongs_to :user
  has_many :resources, dependent: :destroy
  has_many :columns, dependent: :destroy
  has_many :todos, through: :columns
  has_many :user_topics, dependent: :destroy
  has_many :users, through: :user_topics
  validates :title, presence: true
  validates :color, presence: true
end
