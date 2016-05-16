require 'rails_helper'
require 'faker'

RSpec.describe Wiki, type: :model do
  let(:user) { User.create!(email: "user@blocipedia.com", password: "password") }
  let(:wiki) { Wiki.create!(title: "New Wiki Title", body: "New Wiki Body", user: user) }

  it { is_expected.to belong_to(:user) }

  describe "attributes" do
    it "has title, body and user attributes" do
      expect(wiki).to have_attributes(title: "New Wiki Title", body: "New Wiki Body", user: user)
    end
  end

  describe "scopes" do
    before do
      @public_wiki = Wiki.create(title: Faker::Lorem.sentence, body: Faker::Lorem.paragraph, user: user, private: false)
      @private_wiki = Wiki.create(title: Faker::Lorem.sentence, body: Faker::Lorem.paragraph, user: user, private: true)
    end

    describe "visible_to(user)" do
      it "returns only public wikis if user is nil" do
        expect(Wiki.visible_to(nil)).to eq([@public_wiki])
      end
    end
  end
end
