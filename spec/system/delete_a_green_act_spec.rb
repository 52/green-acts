require "rails_helper"
require "support/system"
require "support/factory_bot"
require "support/devise"

RSpec.describe "delete a green act", type: :system do
  let(:owner){create :user}
  let!(:green_act){create :green_act, user: owner}

  shared_examples "cannot delete" do
    it "cannot delete a green act" do
      visit "/"
      expect(page).not_to have_link "Delete"
    end
  end

  context "guest user" do
    include_examples "cannot delete"
  end

  context "signed-in user but not owner" do
    let(:another_user){create :user}
    before{sign_in another_user}

    include_examples "cannot delete"
  end

  context "owner" do
    before{sign_in owner}
    it "can delete his own green act", js: true do
      visit "/"
      click_link "Delete"
      page.driver.browser.switch_to.alert.accept
      expect(page).not_to have_content green_act.content
    end
  end
end
