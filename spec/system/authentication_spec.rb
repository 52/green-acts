require "rails_helper"
require "support/system"
require "support/factory_bot"
require "support/devise"
require "support/signup_form"
require "support/signin_form"

RSpec.describe "authentication", type: :system do
  let!(:user){create :user}

  describe "signup" do
    let!(:signup_form){SignupForm.new}

    context "with valid information" do
      specify "user can sign up" do
        signup_form.visit_page.fill_in_form.submit
        expect(page).to have_content "Welcome! You have signed up successfully."
        expect(page).to have_link "Sign Out"
        expect(page).not_to have_link "Sign Up"
        expect(page).not_to have_link "Sign In"
      end
    end

    context "with invalid information" do
      specify "user cannot sign up" do
        signup_form.visit_page.fill_in_form(name: "").submit
        expect(page).to have_content "Name can't be blank"
        expect(page).not_to have_link "Sign Out"
      end
    end
  end

  describe "sign in" do
    let!(:signin_form){SigninForm.new}

    context "with valid information" do
      specify "user can sign in" do
        signin_form.visit_page
                   .fill_in_form(email: user.email, password: user.password)
                   .submit
        expect(page).to have_content "Signed in successfully."
        expect(page).to have_link "Sign Out"
        expect(page).not_to have_link "Sign In"
        expect(page).not_to have_link "Sign Up"
      end
    end

    context "with invalid information" do
      specify "user cannot sign in" do
        signin_form.visit_page
                   .fill_in_form(email: "", password: "")
                   .submit
        expect(page).to have_content "Invalid Email or password"
        expect(page).not_to have_link "Sign Out"
        expect(page).to have_link "Sign In"
        expect(page).to have_link "Sign Up"
      end
    end
  end

  describe "sign out" do
    before{sign_in user}

    specify "user can sign out" do
      visit "/"
      expect(page).to have_link "Sign Out"
      expect(page).not_to have_link "Sign In"

      click_link "Sign Out"
      expect(page).to have_content "Signed out successfully."
      expect(page).to have_link "Sign In"
      expect(page).to have_link "Sign Up"
      expect(page).not_to have_link "Sign Out"
    end
  end
end
