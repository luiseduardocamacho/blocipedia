class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  after_initialize { self.role ||= :standard }

  has_many :wikis
  has_many :collaborations
  has_many :wiki_collaborations, through: :collaborations, source: :wiki

  default_scope { order('created_at DESC') }

         before_save { self.email = email.downcase }

        #  validates :password, presence: true, length: { minimum: 6 }, if: "password.nil?"
        #  validates :password, length: { minimum: 6 }, allow_blank: true

         EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

         validates :email,
            presence: true,
            length: { minimum: 8, maximum: 100 },
            format: { with: EMAIL_REGEX }

  enum role: [:standard, :premium, :admin]

end
