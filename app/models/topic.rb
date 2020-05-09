class Topic < ApplicationRecord
  has_many :resources, dependent: :destroy
  has_many :columns, dependent: :destroy
  has_many :todos, through: :columns
  validates :title, presence: true
  validates :color, presence: true
  belongs_to :user
end
