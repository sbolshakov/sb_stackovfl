class Question < ActiveRecord::Base
  validates :title, :body, :user_id, presence: true
  validates :title, length: { maximum: 200 }

  has_many :answers, dependent: :destroy
  belongs_to :user
end
