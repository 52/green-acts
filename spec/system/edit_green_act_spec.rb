require "rails_helper"
require "support/system"
require "support/factory_bot"
require "support/devise"
require "support/edit_green_act_form"

RSpec.describe "edit green act", type: :system do
  let!(:owner){create :user}
  let!(:green_act){create :green_act, user: owner}

  context "guest user" do
    it "cannot edit green act" do
      visit "/"
      expect(page).not_to have_link "Edit"
    end
  end

  context "signed-in user but not owner" do
    let(:another_user){create :user}
    before{sign_in another_user}

    it "cannot edit green act of other user" do
      visit "/"
      expect(page).not_to have_link "Edit"
    end
  end

  context "owner" do
    let(:edit_green_act_form){EditGreenActForm.new}
    before{sign_in owner}

    context "when fill in form with valid info" do
      it "can edit his own green act" do
        edit_green_act_form.visit_page
                           .fill_in_form(content: "I actually did this")
                           .submit
        expect(page).to have_content "I actually did this"
      end
    end

    context "when fill in form with invalid info" do
      it "cannot edit his own green act" do
        edit_green_act_form.visit_page
                           .fill_in_form(content: "")
                           .submit
        expect(page).to have_content "is required"
        visit "/"
        expect(page).to have_content green_act.content
      end
    end
  end
end
