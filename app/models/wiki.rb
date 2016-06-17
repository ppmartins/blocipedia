class Wiki < ActiveRecord::Base
  belongs_to :user, dependent: :destroy

  def self.visible_to(user)
    if user.admin? || user.premium?
      all
    else
      where(private: false)
    end
  end
end
