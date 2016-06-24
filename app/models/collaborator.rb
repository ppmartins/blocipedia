class Collaborator < ActiveRecord::Base
    belongs_to :user
    belongs_to :wiki

    delegate :email, to: :user, allow_nil: false

#  def self.users
#    User.where( id: pluck(:user_id) )
#  end

  def self.wikis
    Wiki.where( id: pluck(:wiki_id) )
  end

#  def user_id
#    User.find(user_id)
#  end

#  def wiki
#    Wiki.find(wiki_id)
#  end
end
