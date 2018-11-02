require "rails_helper"
require "support/system"
require "support/factory_bot"
require "support/devise"

require "support/create_green_act_form"

RSpec.describe "create new green act" do
  context "guest user" do
    it "can not create new green act" do
      visit "/"
      expect(page).not_to have_link "Share your Green Act"
    end
  end

  context "signed in user" do
    let(:user){create :user}
    let(:create_green_act_form){CreateGreenActForm.new}
    before{sign_in user}

    context "fills in form with valid info" do
      it "can create new green act" do
        create_green_act_form.visit_page.fill_in_form(content: "Go Green").submit
        visit "/"
        expect(page).to have_content "Go Green"
      end
    end

    context "fills in form with invalid info" do
      it "cannot create new green act" do
        create_green_act_form.visit_page.fill_in_form(content: "").submit
        expect(page).to have_content "is required"
      end
    end
  end
end
