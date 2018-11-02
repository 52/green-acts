require "rails_helper"
require "support/shoulda_matchers"

RSpec.describe GreenAct, type: :model do
  describe "validation" do
    it{should validate_presence_of(:content).with_message("is required")}
    it{should validate_length_of(:content).is_at_most(280)}
    it{should validate_length_of(:details).is_at_most(10_000)}

    it{should belong_to :user}
  end
end
