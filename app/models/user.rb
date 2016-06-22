class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise  :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable,
          :registerable, :confirmable

  before_save { self.email = email.downcase }

  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :email,
            presence: true,
            uniqueness: { case_sensitive: false },
            format: { with: EMAIL_REGEX }

  has_many :wikis
  has_many :collaborators

  after_initialize { self.role ||= :member }

  enum role: [:member, :admin, :premium]

  delegate :wikis, to: :collaborators

  def collaborators
    Collaborator.where(user_id: id)
  end
end
