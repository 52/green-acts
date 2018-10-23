require "rails_helper"
require "support/factory_bot"
require "support/shoulda_matchers"

RSpec.describe User, type: :model do
  describe "validation" do
    it{should validate_presence_of :name}
    it{should validate_presence_of :username}
    it{should validate_presence_of :email}
    it{should validate_length_of(:name).is_at_least(2).is_at_most(25)}
    it{should validate_length_of(:username).is_at_least(2).is_at_most(25)}

    subject{create :user}
    it{should validate_uniqueness_of(:username).case_insensitive}

    it{should allow_value("user_name").for(:username)}
    it{should_not allow_value("user name").for(:username)}
  end
end
