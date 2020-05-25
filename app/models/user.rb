class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :todos
  has_many :resources
  has_many :columns
  has_many  :topics
  has_many :user_topics, dependent: :destroy
  has_many :invited_topics, through: :user_topics, source: :topic

  def accepted_topics
    Topic.includes(:user_topics).where(user_topics: { accepted: true, user_id: id })
  end
end
