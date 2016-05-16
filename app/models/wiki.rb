class Wiki < ActiveRecord::Base
  belongs_to :user
  has_many :collaborations
  has_many :collaborators, through: :collaborations, source: :user

  validates :title, presence: true, length: {minimum: 4}
  validates :body, presence: true
  validates :user, presence: true

  scope :visible_to, -> (user) { user ? all : where(private: false) }

end
