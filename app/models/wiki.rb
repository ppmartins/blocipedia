class Wiki < ActiveRecord::Base
  belongs_to :user, dependent: :destroy
  scope :visible_to, -> (user) { user ? all : where(private: false) }
end
