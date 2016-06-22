class Wiki < ActiveRecord::Base
  belongs_to :user, dependent: :destroy
  has_many :users, through: :collaborators

  def self.visible_to(user)
    if user.admin? || user.premium?
      all
    else
      where(private: false)
    end
  end

  delegate :collaborators, to: :users

  def collaborators
    Collaborator.where(wiki_id: id)
  end
end
