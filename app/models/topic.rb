class Topic < ApplicationRecord
  has_many :todos, dependent: :destroy
  has_many :resources, dependent: :destroy
end
